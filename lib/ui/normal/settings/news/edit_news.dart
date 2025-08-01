import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/news/edit_news.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/news/edit_news.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/settings/news/edit_news_translation.dart';
import 'package:app/ui/normal/settings/news/view_news.dart';
import 'package:app/ui_utils/consts/animation.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/list.dart';

final log = Logger("EditNewsScreen");

Future<void> openEditNewsScreen(
  BuildContext context,
  NewsId id,
  List<String> supportedLocales,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => EditNewsBloc(id, supportedLocales: supportedLocales),
        lazy: false,
        child: EditNewsScreen(pageKey: pageKey, supportedLocales: supportedLocales)
      ),
    ),
    pageKey,
  );
}

class EditNewsScreen extends StatefulWidget {
  final PageKey pageKey;
  final List<String> supportedLocales;
  const EditNewsScreen({
    required this.pageKey,
    required this.supportedLocales,
    super.key,
  });

  @override
  State<EditNewsScreen> createState() => EditNewsScreenState();
}

class EditNewsScreenState extends State<EditNewsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditNewsBloc, EditNewsData>(
      builder: (context, state) {
        return PopScope(
          canPop: !state.unsavedChanges(),
          onPopInvokedWithResult: (didPop, _) async {
            if (!didPop) {
              final r = await showConfirmDialog(context, "Discard changes?", yesNoActions: true);
              if (r == true && context.mounted) {
                MyNavigator.removePage(context, widget.pageKey);
              }
            }
          },
          child: screen(state),
        );
      }
    );
  }

  Widget screen(EditNewsData state) {
    final Widget toggleVisibilityAction;
    if (!state.unsavedChanges() && !state.isLoading && !state.isError) {
      final IconData icon;
      final String dialogTitle;
      if (state.isVisibleToUsers) {
        icon = Icons.public;
        dialogTitle = "Make private?";
      } else {
        icon = Icons.public_off;
        dialogTitle = "Make public?";
      }
      toggleVisibilityAction = IconButton(
        icon: Icon(icon),
        onPressed: () async {
          final bloc = context.read<EditNewsBloc>();
          final r = await showConfirmDialog(context, dialogTitle, yesNoActions: true);
          if (r == true && !bloc.isClosed) {
            bloc.add(SetVisibilityToServer(!state.isVisibleToUsers));
          }
        },
      );
    } else {
      toggleVisibilityAction = const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          toggleVisibilityAction
        ],
      ),
      body: content(state),
      floatingActionButton: BlocBuilder<EditNewsBloc, EditNewsData>(
        builder: (context, state) {
          if (state.unsavedChanges()) {
            return FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () async {
                final r = await showConfirmDialog(context, context.strings.generic_save_confirmation_title);
                if (r == true && context.mounted) {
                  context.read<EditNewsBloc>().add(SaveToServer());
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget content(EditNewsData state) {
    final Widget w;
    if (state.isLoading) {
      w = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.isError) {
      w = buildListReplacementMessageSimple(
        context, context.strings.generic_error_occurred
      );
    } else {
      w = viewTranslations(context, state);
    }
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: w,
    );
  }

  Widget viewTranslations(BuildContext context, EditNewsData state) {
    final String visibilityText;
    if (state.isVisibleToUsers) {
      visibilityText = "Visibility: public";
    } else {
      visibilityText = "Visibility: private (admins can view)";
    }
    final List<Widget> widgets = [
      Text(visibilityText),
    ];
    for (final l in widget.supportedLocales) {
      final c = state.editedOrCurrentlNewsContent(l);
      widgets.add(const Divider());
      widgets.addAll(newsContentToWidgets(context, l, c));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      )
    );
  }

  List<Widget> newsContentToWidgets(BuildContext context, String locale, NewsContent c) {
    final String title;
    if (c.title.isEmpty) {
      title = context.strings.generic_empty;
    } else {
      title = c.title;
    }
    final String body;
    if (c.body.isEmpty) {
      body = context.strings.generic_empty;
    } else {
      body = c.body;
    }
    return [
      Row(
        children: [
          Text(locale),
          const Spacer(),
          IconButton(
            onPressed: () {
              openEditNewsTranslationScreen(context, c, locale, context.read<EditNewsBloc>());
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      ViewNewsItem(title: title, body: body),
    ];
  }
}
