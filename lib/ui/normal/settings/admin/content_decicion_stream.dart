import 'package:app/api/server_connection_manager.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContentDecicionScreen<C extends ContentInfoGetter> extends StatefulWidget {
  final String title;
  final String? screenInstructions;
  final double infoMessageRowHeight;
  final ContentIo<C> io;
  final ContentUiBuilder<C> builder;
  final ApiManager api;
  const ContentDecicionScreen({
    required this.title,
    this.screenInstructions,
    required this.infoMessageRowHeight,
    required this.io,
    required this.builder,
    required this.api,
    super.key,
  });

  @override
  State<ContentDecicionScreen<C>> createState() => _ContentDecicionScreenState<C>();
}

class _ContentDecicionScreenState<C extends ContentInfoGetter>
    extends State<ContentDecicionScreen<C>> {
  final ItemPositionsListener _listener = ItemPositionsListener.create();
  late final ContentDecicionStreamLogic<C> _logic;

  late final Stream<ContentDecicionStreamStatus> _stream;
  bool _scrollUpActionIsAccept = true;

  /// List item size changes cause issues when scrolling upwards, so
  /// cache latest state for each row.
  Map<int, RowState<C>> rowStateCache = {};

  @override
  void initState() {
    super.initState();
    _logic = ContentDecicionStreamLogic<C>(widget.api, widget.io);
    _logic.reset();
    _listener.itemPositions.addListener(positionListener);
    _stream = _logic.moderationStatus;
  }

  void positionListener() {
    final firstVisible = _listener.itemPositions.value.firstOrNull;
    if (firstVisible != null && widget.builder.allowAccepting) {
      _logic.moderateRow(firstVisible.index - 1, _scrollUpActionIsAccept);
    }
  }

  @override
  Widget build(BuildContext context) {
    final instructions = widget.screenInstructions;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.builder.allowAccepting && widget.builder.allowRejecting)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  if (_scrollUpActionIsAccept) {
                    _scrollUpActionIsAccept = false;
                  } else {
                    _scrollUpActionIsAccept = true;
                  }
                });
              },
              icon: Icon(
                Icons.arrow_upward,
                color: _scrollUpActionIsAccept ? Colors.green : Colors.red,
              ),
              label: Text(_scrollUpActionIsAccept ? "Accept" : "Reject"),
            ),
          if (instructions != null)
            IconButton(
              onPressed: () {
                showInfoDialog(context, instructions);
              },
              icon: const Icon(Icons.info),
            ),
        ],
      ),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, state) {
        final d = state.data;
        switch (d) {
          case ContentDecicionStreamStatus.allHandled:
            return buildEmptyText(context, widget.infoMessageRowHeight);
          case ContentDecicionStreamStatus.handling:
            return ScrollablePositionedList.separated(
              itemCount: 1000000,
              separatorBuilder: (context, i) {
                return const Divider();
              },
              itemPositionsListener: _listener,
              itemBuilder: (context, index) {
                return UpdatingContentDecicionListItem(
                  logic: _logic,
                  rowStateCache: rowStateCache,
                  index: index,
                  infoMessageRowHeight: widget.infoMessageRowHeight,
                  builder: widget.builder,
                  api: widget.api,
                );
              },
            );
          case ContentDecicionStreamStatus.loading || null:
            return Center(child: buildProgressIndicator(widget.infoMessageRowHeight));
        }
      },
    );
  }

  @override
  void dispose() {
    _listener.itemPositions.removeListener(positionListener);
    super.dispose();
  }
}

class UpdatingContentDecicionListItem<C extends ContentInfoGetter> extends StatefulWidget {
  final ContentDecicionStreamLogic<C> logic;
  final Map<int, RowState<C>> rowStateCache;
  final int index;
  final double infoMessageRowHeight;
  final ContentUiBuilder<C> builder;
  final ApiManager api;
  const UpdatingContentDecicionListItem({
    required this.logic,
    required this.rowStateCache,
    required this.index,
    required this.infoMessageRowHeight,
    required this.builder,
    required this.api,
    super.key,
  });

  @override
  State<UpdatingContentDecicionListItem<C>> createState() =>
      _UpdatingContentDecicionListItemState();
}

class _UpdatingContentDecicionListItemState<C extends ContentInfoGetter>
    extends State<UpdatingContentDecicionListItem<C>> {
  late final Stream<RowState<C>> stream;

  @override
  void initState() {
    super.initState();
    stream = widget.logic.getRow(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: widget.rowStateCache[widget.index],
      builder: (context, snapshot) {
        final s = snapshot.data;
        if (s != null) {
          widget.rowStateCache[widget.index] = s;
          switch (s) {
            case AllModerated<C>():
              return buildEmptyText(context, widget.infoMessageRowHeight);
            case Loading<C>():
              return buildProgressIndicator(widget.infoMessageRowHeight);
            case ContentRow<C> r:
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: buildRow(context, r, widget.index),
              );
          }
        } else {
          return buildProgressIndicator(widget.infoMessageRowHeight);
        }
      },
    );
  }

  Widget buildRow(BuildContext context, ContentRow<C> r, int index) {
    final Color? color;
    switch (r.status) {
      case RowStatus.accepted:
        color = Theme.of(context).colorScheme.primaryContainer;
      case RowStatus.rejected:
        color = Theme.of(context).colorScheme.errorContainer;
      case RowStatus.decicionNeeded:
        color = null;
    }

    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: buildContent(context, r.content, index, r.rejectedDetails))],
      ),
    );
  }

  Widget buildContent(BuildContext context, C content, int? index, String? rejectedDetails) {
    return InkWell(
      onLongPress: () {
        if (index != null) {
          showActionDialog(context, content, index, rejectedDetails);
        }
      },
      child: widget.builder.buildRowContent(context, content, rejectedDetails: rejectedDetails),
    );
  }

  Future<void> showActionDialog(
    BuildContext context,
    ContentInfoGetter info,
    int index,
    String? currentRejectedDetails,
  ) {
    Widget builder(BuildContext dialogContext, PageCloser<()> closer) {
      final acceptAction = SimpleDialogOption(
        onPressed: () {
          closer.close(dialogContext, ());
          showConfirmDialog(context, "Accept?").then((value) {
            if (value == true) {
              widget.logic.moderateRow(index, true, ignoreSentToServer: true);
            }
          });
        },
        child: const Text("Accept"),
      );

      final rejectAction = SimpleDialogOption(
        onPressed: () {
          closer.close(dialogContext, ());
          showConfirmDialog(context, "Reject?").then((value) {
            if (value == true) {
              widget.logic.moderateRow(index, false, ignoreSentToServer: true);
            }
          });
        },
        child: const Text("Reject"),
      );

      final rejectWithCurrentDetailsAction = SimpleDialogOption(
        onPressed: () {
          closer.close(dialogContext, ());
          widget.logic.moderateRow(
            index,
            false,
            rejectedDetails: currentRejectedDetails,
            ignoreSentToServer: true,
          );
        },
        child: const Text("Reject (current details)"),
      );

      final hasCurrentRejectedDetails =
          currentRejectedDetails != null && currentRejectedDetails.trim().isNotEmpty;

      final rejectWithDetailsAction = SimpleDialogOption(
        onPressed: () {
          closer.close(dialogContext, ());
          showRejectWithDetailsDialog(context).then((details) {
            if (details != null) {
              final trimmed = details.trim();
              widget.logic.moderateRow(
                index,
                false,
                rejectedDetails: trimmed.isEmpty ? null : trimmed,
                ignoreSentToServer: true,
              );
            }
          });
        },
        child: const Text("Reject (new details)"),
      );

      final target = info.target;
      final showAcceptAction =
          widget.logic.acceptingIsPossible(index) && widget.builder.allowAccepting;
      final showRejectAction =
          widget.logic.rejectingIsPossible(index) && widget.builder.allowRejecting;

      return SimpleDialog(
        title: const Text("Select action"),
        children: <Widget>[
          if (showAcceptAction) acceptAction,
          if (showRejectAction) rejectAction,
          if (showRejectAction &&
              widget.builder.rejectionDetailsSupported &&
              hasCurrentRejectedDetails)
            rejectWithCurrentDetailsAction,
          if (showRejectAction && widget.builder.rejectionDetailsSupported) rejectWithDetailsAction,
          if (target == null)
            openAdminSettingsAction(
              context,
              dialogContext,
              closer,
              "Show admin settings",
              info.owner,
            ),
          if (target != null)
            openAdminSettingsAction(
              context,
              dialogContext,
              closer,
              "Show creator admin settings",
              info.owner,
            ),
          if (target != null)
            openAdminSettingsAction(
              context,
              dialogContext,
              closer,
              "Show target admin settings",
              target,
            ),
        ],
      );
    }

    return MyNavigator.showDialog(
      context: context,
      page: ContentDecicionDialog(builder: builder),
    );
  }

  Future<String?> showRejectWithDetailsDialog(BuildContext context) {
    return MyNavigator.showDialog<RejectWithDetailsDialogResult>(
      context: context,
      page: RejectWithDetailsDialog(
        builder: (_, closer) => RejectWithDetailsActionDialog(closer: closer),
      ),
    ).then((value) {
      if (value == null) {
        return null;
      }
      if (value.submit) {
        return value.details;
      }
      return null;
    });
  }

  Widget openAdminSettingsAction(
    BuildContext context,
    BuildContext dialogContext,
    PageCloser<()> closer,
    String title,
    AccountId account,
  ) {
    return SimpleDialogOption(
      onPressed: () {
        closer.close(dialogContext, ());
        getAgeAndNameAndShowAdminSettings(context, widget.api, account);
      },
      child: Text(title),
    );
  }
}

class ContentDecicionDialog extends MyDialogPage<()> {
  ContentDecicionDialog({required super.builder});
}

class RejectWithDetailsDialog extends MyDialogPage<RejectWithDetailsDialogResult> {
  RejectWithDetailsDialog({required super.builder});
}

class RejectWithDetailsDialogResult {
  final bool submit;
  final String details;
  const RejectWithDetailsDialogResult({required this.submit, required this.details});
}

class RejectWithDetailsActionDialog extends StatefulWidget {
  final PageCloser<RejectWithDetailsDialogResult> closer;
  const RejectWithDetailsActionDialog({required this.closer, super.key});

  @override
  State<RejectWithDetailsActionDialog> createState() => _RejectWithDetailsActionDialogState();
}

class _RejectWithDetailsActionDialogState extends State<RejectWithDetailsActionDialog> {
  final detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Reject"),
      content: TextField(
        controller: detailsController,
        autofocus: true,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(hintText: "Rejection details"),
      ),
      actions: [
        TextButton(
          onPressed: () => widget.closer.close(
            context,
            const RejectWithDetailsDialogResult(submit: false, details: ''),
          ),
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: () => widget.closer.close(
            context,
            RejectWithDetailsDialogResult(submit: true, details: detailsController.text),
          ),
          child: Text(context.strings.generic_ok),
        ),
      ],
    );
  }

  @override
  void dispose() {
    detailsController.dispose();
    super.dispose();
  }
}

Widget buildEmptyText(BuildContext context, double height) {
  return SizedBox(
    height: height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(context.strings.generic_empty)],
    ),
  );
}

Widget buildProgressIndicator(double height) {
  return SizedBox(
    height: height,
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    ),
  );
}

abstract class ContentUiBuilder<C extends ContentInfoGetter> {
  bool get allowRejecting => true;
  bool get allowAccepting => true;
  bool get rejectionDetailsSupported => true;
  Widget buildRowContent(BuildContext context, C content, {String? rejectedDetails});
}

abstract class ContentInfoGetter {
  AccountId get owner;
  AccountId? get target => null;
}
