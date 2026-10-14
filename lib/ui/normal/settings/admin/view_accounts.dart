import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewAccountsPage extends MyScreenPageLimited<()> {
  ViewAccountsPage(RepositoryInstances r) : super(builder: (_) => ViewAccountsScreen(r));
}

class ViewAccountsScreen extends StatefulWidget {
  final ApiManager api;
  ViewAccountsScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<ViewAccountsScreen> createState() => _BlockedProfilesScreen();
}

typedef AccountEntry = ProfileIteratorPageValue;

class _BlockedProfilesScreen extends State<ViewAccountsScreen> {
  PagingState<int, AccountEntry> _pagingState = PagingState();

  final Set<AccountEntry> _selectedAccounts = {};

  bool _selectionMode = false;
  bool _actionInProgress = false;

  AccountIdDbValue? iteratorStartPosition;

  bool isDisposed = false;

  void updatePagingState(
    PagingState<int, AccountEntry> Function(PagingState<int, AccountEntry>) action,
  ) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  void _toggleSelection(AccountEntry entry) {
    setState(() {
      if (!_selectedAccounts.remove(entry)) {
        _selectedAccounts.add(entry);
      }
    });
  }

  void _startSelection(AccountEntry entry) {
    setState(() {
      _selectionMode = true;
      _selectedAccounts.add(entry);
    });
  }

  void _clearSelection() {
    setState(() {
      _selectionMode = false;
      _selectedAccounts.clear();
    });
  }

  String _selectedAccountsText() {
    return _selectedAccounts.map((e) => "${e.name}, ${e.age}").join("\n");
  }

  Future<void> _requestDeletion(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      "Request deletion?",
      details: _selectedAccountsText(),
      yesNoActions: true,
      scrollable: true,
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    if (_actionInProgress) {
      showSnackBar(context.strings.generic_previous_action_in_progress);
      return;
    }
    _actionInProgress = true;
    try {
      final selected = _selectedAccounts.toList();
      var successful = 0;
      var failed = false;
      for (final entry in selected) {
        final result = await widget.api.accountAction(
          (api) => api.postSetAccountDeletionRequestState(
            entry.accountId.aid,
            BooleanSetting(value: true),
          ),
        );
        if (result.isErr()) {
          failed = true;
          break;
        }
        successful++;
      }
      if (!context.mounted) {
        return;
      }
      if (failed) {
        showSnackBar(
          "Failed to request deletion: $successful succeeded, ${selected.length - successful} not done",
        );
      } else {
        showSnackBar("Deletion requested successfully");
      }
      _clearSelection();
    } finally {
      _actionInProgress = false;
    }
  }

  Future<void> _deleteAccounts(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      "Delete account?",
      details: _selectedAccountsText(),
      yesNoActions: true,
      scrollable: true,
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    if (_actionInProgress) {
      showSnackBar(context.strings.generic_previous_action_in_progress);
      return;
    }
    _actionInProgress = true;
    try {
      final selected = _selectedAccounts.toList();
      final deletedAccounts = <AccountId>{};
      var failed = false;
      for (final entry in selected) {
        final result = await widget.api.accountAdminAction(
          (api) => api.postDeleteAccount(entry.accountId.aid),
        );
        if (result.isErr()) {
          failed = true;
          break;
        }
        deletedAccounts.add(entry.accountId);
      }
      if (deletedAccounts.isNotEmpty) {
        updatePagingState(
          (s) => s.filterItems((item) => !deletedAccounts.contains(item.accountId)),
        );
      }
      if (!context.mounted) {
        return;
      }
      if (failed) {
        showSnackBar(
          "Failed to delete accounts: ${deletedAccounts.length} deleted, ${selected.length - deletedAccounts.length} not done",
        );
      } else {
        showSnackBar("Accounts deleted successfully");
      }
      _clearSelection();
    } finally {
      _actionInProgress = false;
    }
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

    iteratorStartPosition ??= await widget.api
        .profileAdmin((api) => api.getLatestCreatedAccountIdDb())
        .ok();

    final startPosition = iteratorStartPosition;
    if (startPosition == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    final page = _pagingState.currentPageNumber();
    final data = await widget.api
        .profileAdmin((api) => api.getAdminProfileIteratorPage(startPosition.accountDbId, page))
        .ok();
    if (data == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    updatePagingState((s) => s.copyAndAdd(data.values));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("View accounts"),
            actions: appBarActions(context, state.permissions),
          ),
          body: page(context),
        );
      },
    );
  }

  List<Widget> appBarActions(BuildContext context, Permissions permissions) {
    final canRequestDeletion = permissions.adminRequestAccountDeletion;
    final canDelete = permissions.adminDeleteAccount;
    return [
      if (_selectedAccounts.isNotEmpty && (canRequestDeletion || canDelete))
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'request_deletion') {
              _requestDeletion(context);
            } else if (value == 'delete') {
              _deleteAccounts(context);
            }
          },
          itemBuilder: (context) => [
            if (canRequestDeletion)
              const PopupMenuItem(value: 'request_deletion', child: Text("Request deletion")),
            if (canDelete) const PopupMenuItem(value: 'delete', child: Text("Delete account")),
          ],
        ),
      if (_selectionMode)
        IconButton(
          icon: const Icon(Icons.clear),
          tooltip: "Cancel selection",
          onPressed: _clearSelection,
        ),
    ];
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
          _selectionMode = false;
          _selectedAccounts.clear();
        });
      },
      child: PagedListView(
        state: _pagingState,
        fetchNextPage: _fetchPage,
        builderDelegate: PagedChildBuilderDelegate<AccountEntry>(
          animateTransitions: true,
          itemBuilder: (context, item, index) {
            return ListTile(
              leading: _selectionMode
                  ? Checkbox(
                      value: _selectedAccounts.contains(item),
                      onChanged: (_) => _toggleSelection(item),
                    )
                  : null,
              title: Text("${item.name}, ${item.age}"),
              subtitle: Text(item.accountId.aid),
              onTap: () {
                if (_selectionMode) {
                  _toggleSelection(item);
                } else {
                  getAgeAndNameAndShowAdminSettings(context, widget.api, item.accountId);
                }
              },
              onLongPress: () => _startSelection(item),
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
