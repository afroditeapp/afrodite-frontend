

import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContentDecicionScreen<C extends ContentOwnerGetter> extends StatefulWidget {
  final String title;
  final double infoMessageRowHeight;
  final ContentIo<C> io;
  final ContentUiBuilder<C> builder;
  const ContentDecicionScreen({
    required this.title,
    required this.infoMessageRowHeight,
    required this.io,
    required this.builder,
    super.key,
  });

  @override
  State<ContentDecicionScreen<C>> createState() => _ContentDecicionScreenState<C>();
}

class _ContentDecicionScreenState<C extends ContentOwnerGetter> extends State<ContentDecicionScreen<C>> {
  final ItemPositionsListener _listener = ItemPositionsListener.create();
  late final ContentDecicionStreamLogic<C> _logic;
  final api = LoginRepository.getInstance().repositories.api;

  @override
  void initState() {
    super.initState();
    _logic = ContentDecicionStreamLogic<C>(widget.io);
    _logic.reset();
    _listener.itemPositions.addListener(positionListener);
  }

  void positionListener() {
    final firstVisible = _listener.itemPositions.value.firstOrNull;
    if (firstVisible != null) {
      _logic.moderateRow(firstVisible.index - 1, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return StreamBuilder(
      stream: _logic.moderationStatus,
      builder: (context, state) {
        final d = state.data;
        switch (d) {
          case ContentDecicionStreamStatus.allHandled:
            return buildEmptyText(widget.infoMessageRowHeight);
          case ContentDecicionStreamStatus.handling:
            return ScrollablePositionedList.separated(
              itemCount: 1000000,
              separatorBuilder: (context, i) {
                return const Divider();
              },
              itemPositionsListener: _listener,
              itemBuilder: (context, index) {
                return buildEntry(context, index);
              },
            );
          case ContentDecicionStreamStatus.loading || null:
            return Center(child: buildProgressIndicator(widget.infoMessageRowHeight));
        }
      },
    );
  }

  Widget buildEntry(BuildContext context, int index) {
    return StreamBuilder(
      stream: _logic.getRow(index),
      builder: (context, snapshot) {
        final s = snapshot.data;
        if (s != null) {
          switch (s) {
            case AllModerated<C>() : return buildEmptyText(widget.infoMessageRowHeight);
            case Loading<C>() : return buildProgressIndicator(widget.infoMessageRowHeight);
            case ContentRow<C> r : {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: buildRow(context, r, index),
                  );
                }
              );
            }
          }
        } else {
          return buildProgressIndicator(widget.infoMessageRowHeight);
        }
      }
    );
  }

  Widget buildRow(BuildContext contex, ContentRow<C> r, int index) {
    final Color? color;
    switch (r.status) {
      case RowStatus.accepted: color = Colors.green.shade200;
      case RowStatus.rejected: color = Colors.red.shade200;
      case RowStatus.decicionNeeded: color = null;
    }

    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: buildContent(context, r.content, index)),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context, C content, int? index) {
    return InkWell(
      onLongPress: () {
        if (index != null) {
          showActionDialog(context, content.owner, index);
        }
      },
      child: widget.builder.buildRowContent(context, content),
    );
  }

  Widget buildProgressIndicator(double height) {
    return SizedBox(
      height: height,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      )
    );
  }

  Widget buildEmptyText(double height) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.strings.generic_empty)
        ],
      )
    );
  }

  Future<void> showActionDialog(BuildContext context, AccountId account, int index) {
    final pageKey = PageKey();

    final rejectAction = SimpleDialogOption(
      onPressed: () {
        MyNavigator.removePage(context, pageKey);
        showConfirmDialog(
          context,
          context.strings.generic_reject_question,
        )
        .then(
            (value) {
              if (value == true) {
                _logic.moderateRow(index, false);
              }
            }
        );
      },
      child: const Text("Reject"),
    );

    return MyNavigator.showDialog(
      context: context,
      pageKey: pageKey,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: const Text("Select action"),
          children: <Widget>[
            if (_logic.rejectingIsPossible(index)) rejectAction,
            SimpleDialogOption(
              onPressed: () {
                MyNavigator.removePage(dialogContext, pageKey);
                getAgeAndNameAndShowAdminSettings(context, api, account);
              },
              child: const Text("Show admin settings"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _listener.itemPositions.removeListener(positionListener);
    super.dispose();
  }
}

abstract class ContentUiBuilder<C extends ContentOwnerGetter> {
  Widget buildRowContent(BuildContext context, C content);
}

abstract class ContentOwnerGetter {
  AccountId get owner;
}
