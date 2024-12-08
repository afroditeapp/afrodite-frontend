

import 'package:app/utils/immutable_list.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/login.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/model/freezed/logic/login.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/model/freezed/logic/media/select_content.dart';
import 'package:app/ui/normal/settings/media/current_moderation_request.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/snack_bar.dart';

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
      body: BlocBuilder<LoginBloc, LoginBlocData>(
        builder: (context, lState) {
          return BlocBuilder<SelectContentBloc, SelectContentData>(
            builder: (context, state) {
              final accountId = lState.accountId;
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (accountId == null) {
                return Center(child: Text(context.strings.generic_error));
              } else {
                return selectContentPage(
                  context,
                  accountId,
                  state.availableContent,
                  state.maxContent,
                  state.showAddNewContent,
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
    UnmodifiableList<MyContent> content,
    int maxContent,
    bool showAddNewContent,
  ) {
    final List<Widget> gridWidgets = [];

    gridWidgets.addAll(
      content.map((e) => buildAvailableImg(
        context,
        accountId,
        e.id,
        onTap: () => MyNavigator.pop(context, AccountImageId(accountId, e.id, e.faceDetected))
      ))
    );

    if (showAddNewContent) {
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

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: gridWidgets,
    );

    final List<Widget> widgets = [];

    widgets.add(Padding(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: Text(context.strings.select_content_content_count(content.length.toString(), maxContent.toString())),
    ));

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
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
