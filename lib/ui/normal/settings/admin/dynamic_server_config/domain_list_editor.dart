import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:flutter/material.dart';

class DomainListEditorResult {
  final List<String> domains;
  DomainListEditorResult(this.domains);
}

class DomainListEditorPage extends MyScreenPageLimited<DomainListEditorResult> {
  final String title;
  final String subtitle;
  final List<String> initialDomains;

  DomainListEditorPage({required this.title, required this.subtitle, required this.initialDomains})
    : super(builder: (closer) => DomainListEditorScreen(title, subtitle, initialDomains, closer));
}

class DomainListEditorScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<String> initialDomains;
  final PageCloser<DomainListEditorResult> closer;

  const DomainListEditorScreen(
    this.title,
    this.subtitle,
    this.initialDomains,
    this.closer, {
    super.key,
  });

  @override
  State<DomainListEditorScreen> createState() => _DomainListEditorScreenState();
}

class _DomainListEditorScreenState extends State<DomainListEditorScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialDomains.join('\n'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _parsedDomains() {
    return _controller.text.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        widget.closer.close(context, DomainListEditorResult(_parsedDomains()));
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.subtitle, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _controller,
                  minLines: 5,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "example.com\nother.org",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
