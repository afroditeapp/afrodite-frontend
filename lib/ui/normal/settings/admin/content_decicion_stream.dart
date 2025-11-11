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
      _logic.moderateRow(firstVisible.index - 1, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final instructions = widget.screenInstructions;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
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
        children: [Expanded(child: buildContent(context, r.content, index))],
      ),
    );
  }

  Widget buildContent(BuildContext context, C content, int? index) {
    return InkWell(
      onLongPress: () {
        if (index != null) {
          showActionDialog(context, content, index);
        }
      },
      child: widget.builder.buildRowContent(context, content),
    );
  }

  Future<void> showActionDialog(BuildContext context, ContentInfoGetter info, int index) {
    Widget builder(BuildContext dialogContext, PageCloser<()> closer) {
      final rejectAction = SimpleDialogOption(
        onPressed: () {
          closer.close(dialogContext, ());
          showConfirmDialog(context, dialogContext.strings.generic_reject_question).then((value) {
            if (value == true) {
              widget.logic.moderateRow(index, false);
            }
          });
        },
        child: const Text("Reject"),
      );

      final target = info.target;

      return SimpleDialog(
        title: const Text("Select action"),
        children: <Widget>[
          if (widget.logic.rejectingIsPossible(index) && widget.builder.allowRejecting)
            rejectAction,
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
  Widget buildRowContent(BuildContext context, C content);
}

abstract class ContentInfoGetter {
  AccountId get owner;
  AccountId? get target => null;
}
