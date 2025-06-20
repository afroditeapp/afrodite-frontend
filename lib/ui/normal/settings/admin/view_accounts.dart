import 'dart:async';

import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/extensions/other.dart';
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
  PagingState<int, AccountEntry> _pagingState = PagingState();

  final api = LoginRepository.getInstance().repositories.api;

  AccountIdDbValue? iteratorStartPosition;

  bool isDisposed = false;

  void updatePagingState(PagingState<int, AccountEntry> Function(PagingState<int, AccountEntry>) action) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  void _fetchPage() async {
    if (_pagingState.isLoading) {
      return;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    if (_pagingState.isInitialPage()) {
      iteratorStartPosition = null;
    }

    iteratorStartPosition ??= await api.profileAdmin((api) => api.getLatestCreatedAccountIdDb()).ok();

    final startPosition = iteratorStartPosition;
    if (startPosition == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    final page = _pagingState.currentPageNumber();
    final data = await api.profileAdmin((api) => api.getAdminProfileIteratorPage(startPosition.accountDbId, page)).ok();
    if (data == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    updatePagingState((s) => s.copyAndAdd(data.values));
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
      onRefresh: () async {
        if (_pagingState.isLoading) {
          return;
        }
        setState(() {
          _pagingState = PagingState();
        });
      },
      child: PagedListView(
        state: _pagingState,
        fetchNextPage: _fetchPage,
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
    isDisposed = true;
    super.dispose();
  }
}
