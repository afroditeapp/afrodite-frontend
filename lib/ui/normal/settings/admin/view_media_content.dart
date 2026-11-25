import 'dart:math';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/time.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

const List<(bool?, String)> _boolFilterOptions = [(null, "Any"), (true, "Yes"), (false, "No")];

const List<(ContentModerationState, String)> _moderationStateOptions = [
  (ContentModerationState.inSlot, "In slot"),
  (ContentModerationState.waitingAdminBot, "Waiting admin bot"),
  (ContentModerationState.waitingAdmin, "Waiting admin"),
  (ContentModerationState.acceptedByAdminBot, "Accepted by admin bot"),
  (ContentModerationState.acceptedByAdmin, "Accepted by admin"),
  (ContentModerationState.rejectedByAdminBot, "Rejected by admin bot"),
  (ContentModerationState.rejectedByAdmin, "Rejected by admin"),
];

/// Grid item max widths which the user can cycle through. The default (medium)
/// results in two columns on typical phone screens.
const List<double> _gridItemSizes = [120, 140, 200, 400];

/// Vertical padding around the extra info rows.
const double _infoVerticalPadding = 2.0;

/// Extra vertical space reserved inside a single extra info text row.
const double _infoRowExtraHeight = 4.0;

Widget _filterDropdown<T>({
  required String label,
  required List<(T, String)> options,
  required int selectedIndex,
  required ValueChanged<int> onChanged,
}) {
  return DropdownButtonFormField<int>(
    initialValue: selectedIndex,
    decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    items: [
      for (final (index, option) in options.indexed)
        DropdownMenuItem<int>(value: index, child: Text(option.$2)),
    ],
    onChanged: (value) {
      if (value != null) {
        onChanged(value);
      }
    },
  );
}

/// Media content browsing settings screen. Configure filters and extra info
/// here and then press Browse to open [BrowseMediaContentPage].
class ViewMediaContentPage extends MyScreenPageLimited<()> {
  ViewMediaContentPage(RepositoryInstances r) : super(builder: (_) => ViewMediaContentScreen(r));
}

class ViewMediaContentScreen extends StatefulWidget {
  final ApiManager api;
  ViewMediaContentScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<ViewMediaContentScreen> createState() => _ViewMediaContentScreenState();
}

class _ViewMediaContentScreenState extends State<ViewMediaContentScreen> {
  int _faceDetectedIndex = 0;
  int _faceDetectedManualSetIndex = 0;
  int _inUseIndex = 0;
  int _initialContentIndex = 0;
  int _secureCaptureIndex = 0;

  final Set<ContentModerationState> _moderationStates = {};

  DateTime? _uploadedAfter;
  DateTime? _uploadedBefore;

  final MediaContentExtraInfoSettings _extraInfo = MediaContentExtraInfoSettings();

  bool get _nameAndAge => _extraInfo.name && _extraInfo.age;

  void _setNameAndAge(bool value) {
    _extraInfo.name = value;
    _extraInfo.age = value;
  }

  MediaContentFilters? _buildFilters() {
    final filters = MediaContentFilters(
      faceDetected: _boolFilterOptions[_faceDetectedIndex].$1,
      faceDetectedManualSet: _boolFilterOptions[_faceDetectedManualSetIndex].$1,
      inUse: _boolFilterOptions[_inUseIndex].$1,
      initialContent: _boolFilterOptions[_initialContentIndex].$1,
      secureCapture: _boolFilterOptions[_secureCaptureIndex].$1,
      moderationStates: _moderationStates.toList(),
      uploadedAfterUnixTime: _uploadedAfter == null
          ? null
          : UtcDateTime.fromDateTime(_uploadedAfter!).toUnixTime(),
      // Include the whole selected day.
      uploadedBeforeUnixTime: _uploadedBefore == null
          ? null
          : UtcDateTime.fromDateTime(_uploadedBefore!.add(const Duration(days: 1))).toUnixTime(),
    );
    if (filters.faceDetected == null &&
        filters.faceDetectedManualSet == null &&
        filters.inUse == null &&
        filters.initialContent == null &&
        filters.secureCapture == null &&
        filters.moderationStates.isEmpty &&
        filters.uploadedAfterUnixTime == null &&
        filters.uploadedBeforeUnixTime == null) {
      return null;
    }
    return filters;
  }

  MediaContentExtraInfoSettings _copyExtraInfo() {
    return MediaContentExtraInfoSettings(
      age: _extraInfo.age,
      faceDetected: _extraInfo.faceDetected,
      initialContent: _extraInfo.initialContent,
      moderationState: _extraInfo.moderationState,
      moderatorAccountId: _extraInfo.moderatorAccountId,
      name: _extraInfo.name,
      rejectedReasonCategory: _extraInfo.rejectedReasonCategory,
      rejectedReasonDetails: _extraInfo.rejectedReasonDetails,
      secureCapture: _extraInfo.secureCapture,
      uploadTime: _extraInfo.uploadTime,
    );
  }

  void _browse(BuildContext context) {
    FocusScope.of(context).unfocus();
    MyNavigator.pushLimited(
      context,
      BrowseMediaContentPage(widget.api, filters: _buildFilters(), extraInfo: _copyExtraInfo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("View media content"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: "Browse",
                onPressed: () => _browse(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsCategoryTitle(context, "Filters"),
                ...filterWidgets(context),
                settingsCategoryTitle(context, "Extra info"),
                ...extraInfoWidgets(context),
                const Padding(padding: EdgeInsets.all(8.0)),
                hPad(
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _browse(context),
                      icon: const Icon(Icons.search),
                      label: const Text("Browse"),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: LIST_END_EMPTY_AREA)),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> filterWidgets(BuildContext context) {
    return [
      hPad(
        _filterDropdown<bool?>(
          label: "Face detected",
          options: _boolFilterOptions,
          selectedIndex: _faceDetectedIndex,
          onChanged: (value) => setState(() => _faceDetectedIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "Face detected value manually set",
          options: _boolFilterOptions,
          selectedIndex: _faceDetectedManualSetIndex,
          onChanged: (value) => setState(() => _faceDetectedManualSetIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "In use",
          options: _boolFilterOptions,
          selectedIndex: _inUseIndex,
          onChanged: (value) => setState(() => _inUseIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "Initial content",
          options: _boolFilterOptions,
          selectedIndex: _initialContentIndex,
          onChanged: (value) => setState(() => _initialContentIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "Secure capture",
          options: _boolFilterOptions,
          selectedIndex: _secureCaptureIndex,
          onChanged: (value) => setState(() => _secureCaptureIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(Text("Moderation state", style: Theme.of(context).textTheme.titleSmall)),
      const Padding(padding: EdgeInsets.all(4.0)),
      hPad(
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final (state, text) in _moderationStateOptions)
              FilterChip(
                label: Text(text),
                selected: _moderationStates.contains(state),
                showCheckmark: false,
                onSelected: (selected) => setState(() {
                  if (selected) {
                    _moderationStates.add(state);
                  } else {
                    _moderationStates.remove(state);
                  }
                }),
              ),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _dateFilterRow(
          context,
          label: "Uploaded after",
          value: _uploadedAfter,
          onChanged: (value) => setState(() => _uploadedAfter = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _dateFilterRow(
          context,
          label: "Uploaded before",
          value: _uploadedBefore,
          onChanged: (value) => setState(() => _uploadedBefore = value),
        ),
      ),
    ];
  }

  Widget _dateFilterRow(
    BuildContext context, {
    required String label,
    required DateTime? value,
    required ValueChanged<DateTime?> onChanged,
  }) {
    final localeString = Localizations.localeOf(context).localeString();
    return Row(
      children: [
        Expanded(
          child: Text(
            value == null
                ? label
                : "$label: ${fullTimeString(UtcDateTime.fromDateTime(value), localeString)}",
          ),
        ),
        TextButton(
          onPressed: () async {
            final selected = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now().add(const Duration(days: 1)),
              initialDate: value ?? DateTime.now(),
            );
            if (selected != null) {
              onChanged(selected);
            }
          },
          child: const Text("Select"),
        ),
        if (value != null)
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: "Clear",
            onPressed: () => onChanged(null),
          ),
      ],
    );
  }

  List<Widget> extraInfoWidgets(BuildContext context) {
    Widget switchTile(String title, bool value, void Function(bool) update) {
      return SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: (newValue) => setState(() => update(newValue)),
      );
    }

    return [
      switchTile("Name and age", _nameAndAge, _setNameAndAge),
      switchTile(
        "Face detected",
        _extraInfo.faceDetected,
        (value) => _extraInfo.faceDetected = value,
      ),
      switchTile(
        "Initial content",
        _extraInfo.initialContent,
        (value) => _extraInfo.initialContent = value,
      ),
      switchTile(
        "Moderation state",
        _extraInfo.moderationState,
        (value) => _extraInfo.moderationState = value,
      ),
      switchTile(
        "Moderator account ID",
        _extraInfo.moderatorAccountId,
        (value) => _extraInfo.moderatorAccountId = value,
      ),
      switchTile(
        "Rejected reason category",
        _extraInfo.rejectedReasonCategory,
        (value) => _extraInfo.rejectedReasonCategory = value,
      ),
      switchTile(
        "Rejected reason details",
        _extraInfo.rejectedReasonDetails,
        (value) => _extraInfo.rejectedReasonDetails = value,
      ),
      switchTile(
        "Secure capture",
        _extraInfo.secureCapture,
        (value) => _extraInfo.secureCapture = value,
      ),
      switchTile("Upload time", _extraInfo.uploadTime, (value) => _extraInfo.uploadTime = value),
    ];
  }
}

class BrowseMediaContentPage extends MyScreenPageLimited<()> {
  BrowseMediaContentPage(ApiManager api, {this.filters, this.extraInfo})
    : super(
        builder: (_) => BrowseMediaContentScreen(api, filters: filters, extraInfo: extraInfo),
      );

  final MediaContentFilters? filters;
  final MediaContentExtraInfoSettings? extraInfo;
}

class BrowseMediaContentScreen extends StatefulWidget {
  final ApiManager api;
  final MediaContentFilters? filters;
  final MediaContentExtraInfoSettings? extraInfo;
  const BrowseMediaContentScreen(this.api, {this.filters, this.extraInfo, super.key});

  @override
  State<BrowseMediaContentScreen> createState() => _BrowseMediaContentScreenState();
}

typedef MediaContentEntry = MediaContentIteratorPageValue;

class _BrowseMediaContentScreenState extends State<BrowseMediaContentScreen> {
  PagingState<int, MediaContentEntry> _pagingState = PagingState();

  /// Extra info is shown by default. When hidden only images are shown.
  bool _showExtraInfo = true;

  /// Index of the default (medium) item in [_gridItemSizes].
  int _gridItemSizeIndex = 2;

  /// Number of extra info rows reserved below each image. One row is reserved
  /// for every enabled extra info field so that all selected data is visible
  /// and the grid layout does not jump between items.
  int get _reservedInfoRows {
    final extraInfo = widget.extraInfo;
    if (extraInfo == null) {
      return 0;
    }
    var rows = 0;
    if (extraInfo.name || extraInfo.age) {
      rows++;
    }
    if (extraInfo.moderationState) {
      rows++;
    }
    if (extraInfo.faceDetected) {
      rows++;
    }
    if (extraInfo.initialContent) {
      rows++;
    }
    if (extraInfo.secureCapture) {
      rows++;
    }
    if (extraInfo.uploadTime) {
      rows++;
    }
    if (extraInfo.moderatorAccountId) {
      rows++;
    }
    if (extraInfo.rejectedReasonCategory) {
      rows++;
    }
    if (extraInfo.rejectedReasonDetails) {
      rows++;
    }
    return rows;
  }

  /// Height of a single extra info text row, scaled with the user's text size
  /// setting so that the reserved rows do not clip the text.
  double _infoRowHeight(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.bodySmall?.fontSize ?? 12.0;
    return MediaQuery.textScalerOf(context).scale(fontSize) + _infoRowExtraHeight;
  }

  /// Page number to request next. The server decides the next page number so
  /// that it can skip pages which do not contain any matching content.
  int _nextPage = 0;

  int? _iteratorStartPosition;

  /// In-flight and completed moderator name and age lookups. The future is
  /// cached instead of the resolved value so that items sharing a moderator
  /// share a single request instead of firing one each.
  final Map<String, Future<GetProfileAgeAndName?>> _moderatorInfoCache = {};

  Future<GetProfileAgeAndName?> _resolveModeratorInfo(AccountId moderator) {
    final aid = moderator.aid;
    return _moderatorInfoCache[aid] ??= _fetchModeratorInfo(aid);
  }

  Future<GetProfileAgeAndName?> _fetchModeratorInfo(String aid) async {
    final info = await widget.api.profileAdmin((api) => api.getProfileAgeAndName(aid)).ok();
    // Failures are not cached so that a transient error can be retried.
    if (info == null) {
      _moderatorInfoCache.remove(aid)?.ignore();
    }
    return info;
  }

  /// Set synchronously before the first await so that concurrent
  /// fetchNextPage calls cannot interleave and request the same page twice.
  bool _fetchInProgress = false;

  bool isDisposed = false;

  void updatePagingState(
    PagingState<int, MediaContentEntry> Function(PagingState<int, MediaContentEntry>) action,
  ) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  Future<void> _fetchPage() async {
    if (_fetchInProgress || _pagingState.isLoading) {
      return;
    }
    _fetchInProgress = true;

    try {
      // Yield to a microtask so that setState is not called during build.
      await Future<void>.value();

      updatePagingState((s) => s.copyAndShowLoading());

      if (_pagingState.pages == null) {
        _iteratorStartPosition = null;
        _nextPage = 0;
      }

      _iteratorStartPosition ??= await widget.api
          .mediaAdmin((api) => api.getLatestMediaContentIdDb())
          .ok()
          .then((value) => value?.contentIdDb);

      final startPosition = _iteratorStartPosition;
      if (startPosition == null) {
        updatePagingState((s) => s.copyAndShowError());
        return;
      }

      final requestedPage = _nextPage;
      final data = await widget.api
          .mediaAdmin(
            (api) => api.getAdminMediaContentIteratorPage(
              MediaContentIteratorSettings(
                startPosition: startPosition,
                page: requestedPage,
                filters: widget.filters,
                extraInfo: widget.extraInfo,
              ),
            ),
          )
          .ok();
      if (data == null) {
        updatePagingState((s) => s.copyAndShowError());
        return;
      }

      // Null next page means that the end of the iteration has been reached.
      final nextPage = data.nextPage;
      _nextPage = nextPage ?? requestedPage;
      updatePagingState(
        (s) => s.copyWith(
          isLoading: false,
          pages: [...?s.pages, data.values],
          keys: [...?s.keys, requestedPage],
          hasNextPage: nextPage != null,
        ),
      );
    } finally {
      _fetchInProgress = false;
    }
  }

  Future<void> _showActions(BuildContext context, MediaContentEntry item) async {
    final action = await MyNavigator.showDialog<String>(
      context: context,
      page: _MediaContentActionDialog(
        builder: (dialogContext, closer) {
          return SimpleDialog(
            title: const Text("Select action"),
            children: [
              SimpleDialogOption(
                onPressed: () => closer.close(dialogContext, "view"),
                child: const Text("View image"),
              ),
              SimpleDialogOption(
                onPressed: () => closer.close(dialogContext, "admin_settings"),
                child: const Text("Show admin settings"),
              ),
            ],
          );
        },
      ),
    );

    if (!context.mounted || action == null) {
      return;
    }

    switch (action) {
      case "view":
        openViewImageScreenForAccountImage(context, item.accountId, item.contentId);
      case "admin_settings":
        await getAgeAndNameAndShowAdminSettings(context, widget.api, item.accountId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse media content"),
        actions: [
          IconButton(
            icon: Icon(_showExtraInfo ? Icons.visibility : Icons.visibility_off),
            tooltip: _showExtraInfo ? "Hide extra info" : "Show extra info",
            onPressed: () => setState(() => _showExtraInfo = !_showExtraInfo),
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.grid_view),
            tooltip: "Image size",
            initialValue: _gridItemSizeIndex,
            onSelected: (value) => setState(() => _gridItemSizeIndex = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text("Small")),
              const PopupMenuItem(value: 1, child: Text("3 per row")),
              const PopupMenuItem(value: 2, child: Text("Medium")),
              const PopupMenuItem(value: 3, child: Text("Large")),
            ],
          ),
        ],
      ),
      body: grid(context),
    );
  }

  Widget grid(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (_fetchInProgress || _pagingState.isLoading) {
          return;
        }
        _moderatorInfoCache.clear();
        setState(() {
          _pagingState = PagingState();
          _nextPage = 0;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 4.0;
          final maxItemWidth = _gridItemSizes[_gridItemSizeIndex];
          final availableWidth = constraints.maxWidth - (COMMON_SCREEN_EDGE_PADDING * 2);
          final columns = max(1, (availableWidth / maxItemWidth).ceil());
          final itemWidth = (availableWidth - spacing * (columns - 1)) / columns;
          final infoRowHeight = _infoRowHeight(context);
          final infoHeight = _showExtraInfo && _reservedInfoRows > 0
              ? _reservedInfoRows * infoRowHeight + _infoVerticalPadding * 2
              : 0.0;

          return PagedGridView<int, MediaContentEntry>(
            state: _pagingState,
            fetchNextPage: _fetchPage,
            padding: const EdgeInsets.symmetric(
              horizontal: COMMON_SCREEN_EDGE_PADDING,
              vertical: 4,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              mainAxisExtent: itemWidth + infoHeight,
            ),
            builderDelegate: PagedChildBuilderDelegate<MediaContentEntry>(
              animateTransitions: true,
              itemBuilder: (context, item, index) {
                return _MediaContentGridItem(
                  item: item,
                  showExtraInfo: _showExtraInfo,
                  reservedInfoRows: _reservedInfoRows,
                  infoRowHeight: infoRowHeight,
                  extraInfo: widget.extraInfo,
                  resolveModeratorInfo: _resolveModeratorInfo,
                  onTap: () =>
                      openViewImageScreenForAccountImage(context, item.accountId, item.contentId),
                  onLongPress: () => _showActions(context, item),
                );
              },
              noMoreItemsIndicatorBuilder: (context) {
                final loaded = _pagingState.items?.length ?? 0;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "All loaded ($loaded items)",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return buildListReplacementMessageSimple(context, "No media content found");
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

class _MediaContentActionDialog extends MyDialogPage<String> {
  _MediaContentActionDialog({required super.builder});
}

class _MediaContentGridItem extends StatefulWidget {
  final MediaContentEntry item;
  final bool showExtraInfo;

  /// Number of text rows reserved below the image. Missing rows are rendered as
  /// empty space so that every item has the same height.
  final int reservedInfoRows;

  /// Height of a single reserved text row.
  final double infoRowHeight;

  /// Extra info fields which were requested. One row is rendered per enabled
  /// field so that rows stay aligned between items.
  final MediaContentExtraInfoSettings? extraInfo;
  final Future<GetProfileAgeAndName?> Function(AccountId moderator) resolveModeratorInfo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _MediaContentGridItem({
    required this.item,
    required this.showExtraInfo,
    required this.reservedInfoRows,
    required this.infoRowHeight,
    required this.extraInfo,
    required this.resolveModeratorInfo,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<_MediaContentGridItem> createState() => _MediaContentGridItemState();
}

class _MediaContentGridItemState extends State<_MediaContentGridItem> {
  /// Moderator name and age are resolved lazily so that the grid stays fast.
  GetProfileAgeAndName? _moderatorInfo;
  bool _moderatorInfoLoading = false;

  @override
  void initState() {
    super.initState();
    _moderatorInfoLoading = _shouldResolveModeratorInfo;
    _loadModeratorInfo();
  }

  @override
  void didUpdateWidget(_MediaContentGridItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.moderatorAccountId != widget.item.moderatorAccountId) {
      _moderatorInfo = null;
      _moderatorInfoLoading = _shouldResolveModeratorInfo;
      _loadModeratorInfo();
    } else if (!oldWidget.showExtraInfo &&
        widget.showExtraInfo &&
        _moderatorInfo == null &&
        !_moderatorInfoLoading) {
      _moderatorInfoLoading = _shouldResolveModeratorInfo;
      _loadModeratorInfo();
    }
  }

  bool get _shouldResolveModeratorInfo =>
      widget.showExtraInfo && widget.item.moderatorAccountId != null;

  Future<void> _loadModeratorInfo() async {
    final moderator = widget.item.moderatorAccountId;
    if (moderator == null || !widget.showExtraInfo) {
      return;
    }
    final info = await widget.resolveModeratorInfo(moderator);
    if (!mounted) {
      return;
    }
    setState(() {
      _moderatorInfo = info;
      _moderatorInfoLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        final image = InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: accountImgWidget(
            context,
            widget.item.accountId,
            widget.item.contentId,
            width: size,
            height: size,
            fit: BoxFit.cover,
            cacheSize: ImageCacheSize.constantSquare(context, size),
          ),
        );

        if (!widget.showExtraInfo || widget.reservedInfoRows == 0) {
          return image;
        }

        final lines = _infoLines(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: _infoVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.reservedInfoRows; i++)
                      SizedBox(
                        height: widget.infoRowHeight,
                        child: i < lines.length
                            ? Text(
                                lines[i],
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<String> _infoLines(BuildContext context) {
    final item = widget.item;
    final extraInfo = widget.extraInfo;
    final lines = <String>[];

    if (extraInfo == null) {
      return lines;
    }

    if (extraInfo.name || extraInfo.age) {
      final name = item.name;
      final age = item.age;
      final parts = <String>[?name, if (age != null) "$age"];
      lines.add(parts.join(", "));
    }

    if (extraInfo.moderationState) {
      final moderationState = item.moderationState;
      lines.add(moderationState?.toUiString(context) ?? "");
    }

    if (extraInfo.faceDetected) {
      final faceDetected = item.faceDetected;
      lines.add(faceDetected == null ? "" : (faceDetected ? "Face detected" : "No face"));
    }

    if (extraInfo.initialContent) {
      lines.add(item.initialContent == true ? "Initial content" : "");
    }

    if (extraInfo.secureCapture) {
      lines.add(item.secureCapture == true ? "Secure capture" : "");
    }

    if (extraInfo.uploadTime) {
      final uploadTime = item.uploadTime;
      lines.add(
        uploadTime == null
            ? ""
            : fullTimeString(
                uploadTime.toUtcDateTime(),
                Localizations.localeOf(context).localeString(),
              ),
      );
    }

    if (extraInfo.moderatorAccountId) {
      final moderator = item.moderatorAccountId;
      if (moderator == null) {
        lines.add("");
      } else {
        final info = _moderatorInfo;
        if (info == null) {
          lines.add(_moderatorInfoLoading ? "Moderator: loading" : "Moderator: ${moderator.aid}");
        } else {
          final name = info.name;
          lines.add(name == null ? "Moderator: ${info.age}" : "Moderator: $name, ${info.age}");
        }
      }
    }

    if (extraInfo.rejectedReasonCategory) {
      final category = item.rejectedReasonCategory;
      lines.add(category == null ? "" : "Rejected category: ${category.value}");
    }

    if (extraInfo.rejectedReasonDetails) {
      final details = item.rejectedReasonDetails;
      lines.add(details?.value ?? "");
    }

    return lines;
  }
}
