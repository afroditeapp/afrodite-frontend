

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/select_content.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/model/freezed/logic/media/select_content.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

const SELECT_CONTENT_IMAGE_HEIGHT = 200.0;
const SELECT_CONTENT_IMAGE_WIDTH = 150.0;

/// Returns [AccountImageId?]
class SelectContentPage extends StatefulWidget {
  final SelectContentBloc selectContentBloc;
  const SelectContentPage({
    required this.selectContentBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectContentPage> createState() => _SelectContentPageState();
}

class _SelectContentPageState extends State<SelectContentPage> {

  @override
  void initState() {
    super.initState();
    widget.selectContentBloc.add(ReloadAvailableContent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.select_content_screen_title)),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, aState) {
          return BlocBuilder<SelectContentBloc, SelectContentData>(
            builder: (context, state) {
              final accountId = aState.accountId;
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (accountId == null) {
                return Center(child: Text(context.strings.generic_error));
              } else {
                return selectContentPage(
                  context,
                  accountId,
                  state.availableContent,
                  state.pendingModeration,
                  state.initialModerationOngoing,
                  state.showMakeNewModerationRequest,
                );
              }
            }
          );
        }
      )
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    Iterable<ContentId> content,
    Iterable<ContentId> pendingContent,
    bool initialModerationOngoing,
    bool showAddNewModerationRequest,
  ) {
    final List<Widget> gridWidgets = [];

    if (showAddNewModerationRequest) {
      gridWidgets.add(
        Center(
          child: buildAddNewButton(
            context,
            onTap: () async {
              final list = await openNewModerationRequest(context);
              if (list != null && list.isNotEmpty) {
                widget.selectContentBloc.add(NewModerationRequest(list));
              }
            }
          )
        )
      );
    }

    gridWidgets.addAll(
      pendingContent.map((e) => buildPendingImg(
        context,
        accountId,
        e,
        onTap: () => showSnackBar(context.strings.select_content_screen_info_waiting_moderation),
      ))
    );

    gridWidgets.addAll(
      content.map((e) => buildAvailableImg(
        context,
        accountId,
        e,
        onTap: () => Navigator.of(context).pop(AccountImageId(accountId, e))
      ))
    );

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: gridWidgets,
    );

    final List<Widget> widgets = [];

    if (initialModerationOngoing) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
        child: Text(context.strings.select_content_screen_initial_moderation_ongoing_info),
      ));
    }

    widgets.add(grid);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}

Widget buildAddNewButton(
  BuildContext context,
  {
    required void Function() onTap,
  }
) {
  return Center(
    child: SizedBox(
      width: SELECT_CONTENT_IMAGE_WIDTH,
      height: SELECT_CONTENT_IMAGE_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            width: SELECT_CONTENT_IMAGE_WIDTH,
            height: SELECT_CONTENT_IMAGE_HEIGHT,
            color: Colors.grey,
            child: const Center(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildAvailableImg(
  BuildContext context,
  AccountId accountId,
  ContentId contentId,
  {
    required void Function() onTap
  }
) {
  return Center(
    child: SizedBox(
      width: SELECT_CONTENT_IMAGE_WIDTH,
      height: SELECT_CONTENT_IMAGE_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: accountImgWidgetInk(accountId, contentId),
        ),
      ),
    ),
  );
}

Widget buildPendingImg(
  BuildContext context,
  AccountId accountId,
  ContentId contentId,
  {
    required void Function() onTap
  }
) {
    return Center(
    child: SizedBox(
      width: SELECT_CONTENT_IMAGE_WIDTH,
      height: SELECT_CONTENT_IMAGE_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              accountImgWidgetInk(accountId, contentId),
              Container(
                color: Colors.black54,
                child: const Center(
                  child: Icon(
                    Icons.hourglass_top_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
