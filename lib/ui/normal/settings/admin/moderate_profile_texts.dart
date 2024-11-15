

import 'package:app/logic/admin/profile_text_moderation.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const double ROW_HEIGHT = 100;

class ModerateProfileTextsScreen extends StatefulWidget {
  final bool showTextsWhichBotsCanModerate;
  const ModerateProfileTextsScreen({required this.showTextsWhichBotsCanModerate, super.key});

  @override
  State<ModerateProfileTextsScreen> createState() => _ModerateProfileTextsScreenState();
}

class _ModerateProfileTextsScreenState extends State<ModerateProfileTextsScreen> {
  final ItemPositionsListener _listener = ItemPositionsListener.create();
  final _logic = ProfileTextModerationLogic.getInstance();

  @override
  void initState() {
    super.initState();
    _logic.reset(widget.showTextsWhichBotsCanModerate);
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
      appBar: AppBar(title: const Text("Moderate profile texts")),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return StreamBuilder(
      stream: _logic.moderationStatus,
      builder: (context, state) {
        final d = state.data;
        switch (d) {
          case ProfileTextModerationStatus.allModerated:
            return buildEmptyText(ROW_HEIGHT);
          case ProfileTextModerationStatus.moderating:
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
          case ProfileTextModerationStatus.loading || null:
            return Center(child: buildProgressIndicator(ROW_HEIGHT));
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
            case AllModerated() : return buildEmptyText(ROW_HEIGHT);
            case Loading() : return buildProgressIndicator(ROW_HEIGHT);
            case ProfileTextRow r : {
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
          return buildProgressIndicator(ROW_HEIGHT);
        }
      }
    );
  }

  Widget buildRow(BuildContext contex, ProfileTextRow r, int index) {
    final Color? color;
    switch (r.status) {
      case Accepted(): color = Colors.green.shade200;
      case Denied(): color = Colors.red.shade200;
      case ModerationDecicionNeeded(): color = null;
    }

    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: buildText(contex, r.account, r.text, index)),
        ],
      ),
    );
  }

  Widget buildText(BuildContext contex, AccountId imageOwner, String text, int? index) {
    return InkWell(
      onLongPress: () {
        if (index != null) {
          showActionDialog(imageOwner, index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text),
      ),
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

  Future<void> showActionDialog(AccountId account, int index) {
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
      child: const Text("Reject text"),
    );

    return MyNavigator.showDialog(
      context: context,
      pageKey: pageKey,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select action"),
          children: <Widget>[
            if (_logic.rejectingIsPossible(index)) rejectAction,
            SimpleDialogOption(
              onPressed: () {
                MyNavigator.removePage(context, pageKey);
                showInfoDialog(context, "Account ID\n\n${account.aid}");
              },
              child: const Text("Show info"),
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
