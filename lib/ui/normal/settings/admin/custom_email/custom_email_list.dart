import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/custom_email/custom_email_editor.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/ui_utils/time.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class CustomEmailListPage extends MyScreenPageLimited<()> {
  CustomEmailListPage(RepositoryInstances r) : super(builder: (_) => CustomEmailListScreen(r));
}

class CustomEmailListScreen extends StatefulWidget {
  final ApiManager api;
  CustomEmailListScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<CustomEmailListScreen> createState() => _CustomEmailListScreenState();
}

class _CustomEmailListScreenState extends State<CustomEmailListScreen> {
  int _page = 0;
  List<CustomEmail> _emails = [];
  GetCustomEmailConfig? _config;
  bool _isLoading = true;
  bool _isError = false;
  bool _allLoaded = false;

  bool _loadMoreIsRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMore());
  }

  Future<void> _loadMore() async {
    if (!mounted || _allLoaded || _loadMoreIsRunning) return;

    _loadMoreIsRunning = true;

    _config ??= await widget.api.accountAdmin((api) => api.getCustomEmailConfig()).ok();

    final data = await widget.api.accountAdmin((api) => api.getCustomEmailList(_page)).ok();
    _page += 1;

    if (!mounted) return;

    if (_config == null || data == null) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _emails = [..._emails, ...data];
        _allLoaded = data.isEmpty;
      });
    }

    _loadMoreIsRunning = false;
  }

  Future<void> _reloadData() async {
    _isLoading = true;
    _isError = false;
    _allLoaded = false;
    _emails = [];
    _config = null;
    _page = 0;
    await _loadMore();
  }

  Future<void> _createEmail() async {
    final result = await widget.api.accountAdmin((api) => api.postCreateCustomEmail()).ok();
    if (result == null) {
      showSnackBar("Failed to create custom email");
      return;
    }

    showSnackBar("Custom email created");
    await _reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom emails")),
      floatingActionButton: FloatingActionButton(
        onPressed: _createEmail,
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _emails.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isError && _emails.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Failed to load custom emails"),
            TextButton(onPressed: _loadMore, child: const Text("Retry")),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _reloadData();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _configItem()),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= _emails.length) {
                if (_allLoaded) {
                  return null;
                } else {
                  _loadMore();
                  if (index == _emails.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox(height: 32);
                  }
                }
              }

              final email = _emails[index];
              final defaultTranslation = email.translations
                  .where((t) => t.locale == "default")
                  .firstOrNull;
              final subject = defaultTranslation?.subject ?? "(no default translation)";
              final appLocaleString = Localizations.localeOf(context).localeString();

              return ListTile(
                title: Text(subject),
                subtitle: Text(_emailStatusText(email, appLocaleString)),
                onTap: () async {
                  await MyNavigator.pushLimited(context, CustomEmailEditorPage(widget.api, email));
                  await _reloadData();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String _emailStatusText(CustomEmail email, String appLocaleString) {
    if (email.sendingCompletedUnixTime != null) {
      final time = fullTimeString(
        UtcDateTime.fromUnixEpoch(email.sendingCompletedUnixTime!.ut),
        appLocaleString,
      );
      return "Sent: $time";
    }
    if (email.sendingInitiatedUnixTime != null) {
      final time = fullTimeString(
        UtcDateTime.fromUnixEpoch(email.sendingInitiatedUnixTime!.ut),
        appLocaleString,
      );
      return "Sending initiated: $time";
    }
    return "Draft";
  }

  Widget _configItem() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Custom email config", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (_config == null)
              const Text("Loading...")
            else
              Text("Email body is HTML: ${_config!.emailBodyIsHtml ?? "unknown"}"),
          ],
        ),
      ),
    );
  }
}
