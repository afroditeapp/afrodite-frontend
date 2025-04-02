import 'dart:async';

import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewAccountsScreen extends StatefulWidget {
  const ViewAccountsScreen({super.key});

  @override
  State<ViewAccountsScreen> createState() => _BlockedProfilesScreen();
}

typedef AccountEntry = ProfileIteratorPageValue;

class _BlockedProfilesScreen extends State<ViewAccountsScreen> {
  PagingController<int, AccountEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  final api = LoginRepository.getInstance().repositories.api;

  AccountIdDbValue? iteratorStartPosition;
  int iteratorPage = 0;

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      iteratorStartPosition = null;
      iteratorPage = 0;
    }

    iteratorStartPosition ??= await api.profileAdmin((api) => api.getLatestCreatedAccountIdDb()).ok();

    final startPosition = iteratorStartPosition;
    if (startPosition == null) {
      // Show error UI
      _pagingController?.error = true;
      return;
    }

    final page = await api.profileAdmin((api) => api.getAdminProfileIteratorPage(startPosition.accountDbId, iteratorPage)).ok();
    if (page == null) {
      // Show error UI
      _pagingController?.error = true;
      return;
    }

    iteratorPage += 1;

    if (page.values.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(page.values, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View accounts")),
      body: page(context),
    );
  }

  Widget page(BuildContext context) {
    return grid(context);
  }

  Widget grid(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _pagingController?.refresh(),
      child: PagedListView(
        pagingController: _pagingController!,
        builderDelegate: PagedChildBuilderDelegate<AccountEntry>(
          animateTransitions: true,
          itemBuilder: (context, item, index) {
            return ListTile(
              title: Text("${item.name}, ${item.age}"),
              subtitle: Text(item.accountId.aid),
              onTap: () {
                getAgeAndNameAndShowAdminSettings(context, api, item.accountId);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    super.dispose();
  }
}
