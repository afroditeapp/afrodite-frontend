import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/logic/account/news/edit_news.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/news/edit_news.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/news/view_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openEditNewsTranslationScreen(BuildContext context, NewsContent c, String locale) {
  return MyNavigator.showFullScreenDialog(
    context: context,
    page: EditNewsTranslationPage(initialContent: c, locale: locale),
  );
}

class EditNewsTranslationPage extends MyFullScreenDialogPage<()> {
  EditNewsTranslationPage({required NewsContent initialContent, required String locale})
    : super(
        builder: (closer) => EditNewsTranslationScreen(
          closer: closer,
          initialContent: initialContent,
          locale: locale,
        ),
      );
}

class EditNewsTranslationScreen extends StatefulWidget {
  final PageCloser<()> closer;
  final NewsContent initialContent;
  final String locale;
  const EditNewsTranslationScreen({
    required this.closer,
    required this.initialContent,
    required this.locale,
    super.key,
  });

  @override
  State<EditNewsTranslationScreen> createState() => EditNewsTranslationScreenState();
}

class EditNewsTranslationScreenState extends State<EditNewsTranslationScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  bool showLivePreview = true;

  @override
  void initState() {
    super.initState();
    _titleTextController.text = widget.initialContent.title;
    _bodyTextController.text = widget.initialContent.body;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditNewsBloc>();
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop && mounted && !bloc.isClosed) {
          bloc.add(
            SaveTranslation(widget.locale, (
              title: _titleTextController.text,
              body: _bodyTextController.text,
              version: null,
            )),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.preview),
              tooltip: "Toggle live preview",
              onPressed: () {
                setState(() {
                  showLivePreview = !showLivePreview;
                });
              },
            ),
          ],
        ),
        body: content(),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        if (showLivePreview) Expanded(child: livePreview()),
        Expanded(child: editArea()),
      ],
    );
  }

  Widget editTitleText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _titleTextController,
        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Title text"),
      ),
    );
  }

  Widget editBodyText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _bodyTextController,
        minLines: 3,
        maxLines: null,
        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Body text"),
      ),
    );
  }

  Widget editArea() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [editTitleText(), editBodyText()],
        ),
      ),
    );
  }

  Widget livePreview() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NewsTranslationLivePreview(
          titleController: _titleTextController,
          bodyController: _bodyTextController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _bodyTextController.dispose();
    super.dispose();
  }
}

class NewsTranslationLivePreview extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController bodyController;
  const NewsTranslationLivePreview({
    required this.titleController,
    required this.bodyController,
    super.key,
  });

  @override
  State<NewsTranslationLivePreview> createState() => NewsTranslationLivePreviewState();
}

class NewsTranslationLivePreviewState extends State<NewsTranslationLivePreview> {
  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(titleListener);
    widget.bodyController.addListener(bodyListener);
  }

  void titleListener() {
    setState(() {});
  }

  void bodyListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ViewNewsItem(title: widget.titleController.text, body: widget.bodyController.text),
    );
  }

  @override
  void dispose() {
    widget.titleController.removeListener(titleListener);
    widget.bodyController.removeListener(bodyListener);
    super.dispose();
  }
}
