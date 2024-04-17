

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/select_content.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/model/freezed/logic/media/select_content.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/image.dart';

/// Returns [AccountImageId?]
class SelectContentPage extends StatefulWidget {
  final SelectContentBloc selectContentBloc;
  const SelectContentPage({required this.selectContentBloc, Key? key}) : super(key: key);

  @override
  State<SelectContentPage> createState() => _SelectContentPageState();
}

class _SelectContentPageState extends State<SelectContentPage> {

  @override
  void initState() {
    super.initState();
    widget.selectContentBloc.add(Reload());
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
                  aState.isInitialModerationOngoing(),
                );
              }
            },
          );
        }
      )
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    Iterable<ContentId> content,
    bool initialModerationOngoing
  ) {
    final List<Widget> widgets = [];

    if (initialModerationOngoing) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
        child: Text(context.strings.select_content_screen_initial_moderation_ongoing_info),
      ));
    }

    final imgWidgets = content.map((e) {
      return Center(
        child: SizedBox(
          height: 200,
          width: 150,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(AccountImageId(accountId, e));
              },
              child: accountImgWidgetInk(accountId, e),
            ),
          ),
        ),
      );
    }).toList();

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: imgWidgets,
    );

    widgets.add(grid);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}
