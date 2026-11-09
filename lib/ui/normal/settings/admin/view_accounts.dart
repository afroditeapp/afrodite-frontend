import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const List<(AccountState?, String)> _accountStateFilterOptions = [
  (null, "Any"),
  (AccountState.initialSetup, "Initial setup"),
  (AccountState.normal, "Normal"),
  (AccountState.banned, "Banned"),
  (AccountState.pendingDeletion, "Pending deletion"),
];

const List<(ProfileVisibility?, String)> _profileVisibilityFilterOptions = [
  (null, "Any"),
  (ProfileVisibility.private, "Private"),
  (ProfileVisibility.public, "Public"),
];

const List<(bool?, String)> _accountOnlineFilterOptions = [
  (null, "Any"),
  (true, "Online"),
  (false, "Offline"),
];

const List<(bool?, String)> _attestationValidityFilterOptions = [
  (null, "Any"),
  (true, "Valid"),
  (false, "Not valid"),
];

extension AccountStateUiText on AccountState {
  String toUiString() => switch (this) {
    AccountState.initialSetup => "Initial setup",
    AccountState.normal => "Normal",
    AccountState.banned => "Banned",
    AccountState.pendingDeletion => "Pending deletion",
    AccountState.unknownDefaultOpenApi => "Unknown",
  };
}

Widget _filterDropdown<T>({
  required String label,
  required List<(T, String)> options,
  required int selectedIndex,
  required ValueChanged<int> onChanged,
}) {
  return DropdownButtonFormField<int>(
    initialValue: selectedIndex,
    decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    items: [
      for (final (index, option) in options.indexed)
        DropdownMenuItem<int>(value: index, child: Text(option.$2)),
    ],
    onChanged: (value) {
      if (value != null) {
        onChanged(value);
      }
    },
  );
}

/// Account browsing settings screen. Configure filters and extra info here and
/// then press Browse to open [BrowseAccountsPage].
class ViewAccountsPage extends MyScreenPageLimited<()> {
  ViewAccountsPage(RepositoryInstances r) : super(builder: (_) => ViewAccountsScreen(r));
}

class ViewAccountsScreen extends StatefulWidget {
  final ApiManager api;
  ViewAccountsScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<ViewAccountsScreen> createState() => _ViewAccountsScreenState();
}

class _ViewAccountsScreenState extends State<ViewAccountsScreen> {
  int _accountStateIndex = 0;
  int _profileVisibilityIndex = 0;
  int _accountOnlineIndex = 0;
  int _attestationValidityIndex = 0;

  final TextEditingController _ipCountryController = TextEditingController();

  final AccountExtraInfoSettings _extraInfo = AccountExtraInfoSettings();

  @override
  void dispose() {
    _ipCountryController.dispose();
    super.dispose();
  }

  AccountFilters? _buildFilters() {
    final ipCountry = _ipCountryController.text.trim().toUpperCase();
    final filters = AccountFilters(
      accountOnline: _accountOnlineFilterOptions[_accountOnlineIndex].$1,
      accountState: _accountStateFilterOptions[_accountStateIndex].$1,
      loginSessionBasicAppAttestationValidity:
          _attestationValidityFilterOptions[_attestationValidityIndex].$1,
      loginSessionIpCountryIsNot: ipCountry.isEmpty ? null : ipCountry,
      profileVisibility: _profileVisibilityFilterOptions[_profileVisibilityIndex].$1,
    );
    if (filters.accountOnline == null &&
        filters.accountState == null &&
        filters.loginSessionBasicAppAttestationValidity == null &&
        filters.loginSessionIpCountryIsNot == null &&
        filters.profileVisibility == null) {
      return null;
    }
    return filters;
  }

  AccountExtraInfoSettings _copyExtraInfo() {
    return AccountExtraInfoSettings(
      accountOnline: _extraInfo.accountOnline,
      accountState: _extraInfo.accountState,
      emailAddress: _extraInfo.emailAddress,
      loginSessionAppAttestationInfo: _extraInfo.loginSessionAppAttestationInfo,
      loginSessionClientType: _extraInfo.loginSessionClientType,
      loginSessionIpCountry: _extraInfo.loginSessionIpCountry,
      loginSessionLoginMethod: _extraInfo.loginSessionLoginMethod,
      profileVisibility: _extraInfo.profileVisibility,
    );
  }

  void _browse(BuildContext context) {
    FocusScope.of(context).unfocus();
    MyNavigator.pushLimited(
      context,
      BrowseAccountsPage(widget.api, filters: _buildFilters(), extraInfo: _copyExtraInfo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("View accounts"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: "Browse",
                onPressed: () => _browse(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsCategoryTitle(context, "Filters"),
                ...filterWidgets(context),
                settingsCategoryTitle(context, "Extra info"),
                ...extraInfoWidgets(context, state.permissions),
                const Padding(padding: EdgeInsets.all(8.0)),
                hPad(
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _browse(context),
                      icon: const Icon(Icons.search),
                      label: const Text("Browse"),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: LIST_END_EMPTY_AREA)),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> filterWidgets(BuildContext context) {
    return [
      hPad(
        _filterDropdown<AccountState?>(
          label: "Account state",
          options: _accountStateFilterOptions,
          selectedIndex: _accountStateIndex,
          onChanged: (value) => setState(() => _accountStateIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<ProfileVisibility?>(
          label: "Profile visibility",
          options: _profileVisibilityFilterOptions,
          selectedIndex: _profileVisibilityIndex,
          onChanged: (value) => setState(() => _profileVisibilityIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "Account online",
          options: _accountOnlineFilterOptions,
          selectedIndex: _accountOnlineIndex,
          onChanged: (value) => setState(() => _accountOnlineIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        _filterDropdown<bool?>(
          label: "Login session basic app attestation validity",
          options: _attestationValidityFilterOptions,
          selectedIndex: _attestationValidityIndex,
          onChanged: (value) => setState(() => _attestationValidityIndex = value),
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(
        TextField(
          controller: _ipCountryController,
          decoration: const InputDecoration(
            labelText: "Login session IP country is not",
            helperText: "Two letter country code, for example FI. Empty means no filter.",
            helperMaxLines: 2,
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.characters,
          maxLength: 2,
          onChanged: (_) => setState(() {}),
        ),
      ),
    ];
  }

  List<Widget> extraInfoWidgets(BuildContext context, Permissions permissions) {
    Widget switchTile(String title, bool value, void Function(bool) update) {
      return SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: (newValue) => setState(() => update(newValue)),
      );
    }

    return [
      switchTile(
        "Account online",
        _extraInfo.accountOnline,
        (value) => _extraInfo.accountOnline = value,
      ),
      switchTile(
        "Account state",
        _extraInfo.accountState,
        (value) => _extraInfo.accountState = value,
      ),
      if (permissions.adminViewEmailAddress)
        switchTile(
          "Email address",
          _extraInfo.emailAddress,
          (value) => _extraInfo.emailAddress = value,
        ),
      switchTile(
        "Login session app attestation info",
        _extraInfo.loginSessionAppAttestationInfo,
        (value) => _extraInfo.loginSessionAppAttestationInfo = value,
      ),
      switchTile(
        "Login session client type",
        _extraInfo.loginSessionClientType,
        (value) => _extraInfo.loginSessionClientType = value,
      ),
      switchTile(
        "Login session IP country",
        _extraInfo.loginSessionIpCountry,
        (value) => _extraInfo.loginSessionIpCountry = value,
      ),
      switchTile(
        "Login session login method",
        _extraInfo.loginSessionLoginMethod,
        (value) => _extraInfo.loginSessionLoginMethod = value,
      ),
      switchTile(
        "Profile visibility",
        _extraInfo.profileVisibility,
        (value) => _extraInfo.profileVisibility = value,
      ),
    ];
  }
}

class BrowseAccountsPage extends MyScreenPageLimited<()> {
  BrowseAccountsPage(ApiManager api, {this.filters, this.extraInfo})
    : super(
        builder: (_) => BrowseAccountsScreen(api, filters: filters, extraInfo: extraInfo),
      );

  final AccountFilters? filters;
  final AccountExtraInfoSettings? extraInfo;
}

class BrowseAccountsScreen extends StatefulWidget {
  final ApiManager api;
  final AccountFilters? filters;
  final AccountExtraInfoSettings? extraInfo;
  const BrowseAccountsScreen(this.api, {this.filters, this.extraInfo, super.key});

  @override
  State<BrowseAccountsScreen> createState() => _BrowseAccountsScreenState();
}

typedef AccountEntry = ProfileIteratorPageValue;

class _BrowseAccountsScreenState extends State<BrowseAccountsScreen> {
  PagingState<int, AccountEntry> _pagingState = PagingState();

  final Set<AccountEntry> _selectedAccounts = {};

  bool _selectionMode = false;
  bool _actionInProgress = false;

  AccountIdDbValue? iteratorStartPosition;

  /// Page number to request next. The server decides the next page number so
  /// that it can skip pages which do not contain any matching accounts.
  int _nextPage = 0;

  /// Set synchronously before the first await so that concurrent
  /// fetchNextPage calls cannot interleave and request the same page twice.
  bool _fetchInProgress = false;

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
    return _selectedAccounts
        .map((e) => [e.name ?? "No name", e.age.toString(), ?e.email].join(", "))
        .join("\n");
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
    if (_fetchInProgress || _pagingState.isLoading) {
      return;
    }
    _fetchInProgress = true;

    try {
      // Yield to a microtask so that setState is not called during build.
      await Future<void>.value();

      updatePagingState((s) => s.copyAndShowLoading());

      if (_pagingState.pages == null) {
        iteratorStartPosition = null;
        _nextPage = 0;
      }

      iteratorStartPosition ??= await widget.api
          .profileAdmin((api) => api.getLatestCreatedAccountIdDb())
          .ok();

      final startPosition = iteratorStartPosition;
      if (startPosition == null) {
        updatePagingState((s) => s.copyAndShowError());
        return;
      }

      final requestedPage = _nextPage;
      final data = await widget.api
          .profileAdmin(
            (api) => api.getAdminProfileIteratorPage(
              ProfileIteratorSettings(
                startPosition: startPosition.accountDbId,
                page: requestedPage,
                filters: widget.filters,
                extraInfo: widget.extraInfo,
              ),
            ),
          )
          .ok();
      if (data == null) {
        updatePagingState((s) => s.copyAndShowError());
        return;
      }

      // Null next page means that the end of the iteration has been reached.
      final nextPage = data.nextPage;
      _nextPage = nextPage ?? requestedPage;
      updatePagingState(
        (s) => s.copyWith(
          isLoading: false,
          pages: [...?s.pages, data.values],
          keys: [...?s.keys, requestedPage],
          hasNextPage: nextPage != null,
        ),
      );
    } finally {
      _fetchInProgress = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Browse accounts"),
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
        if (_fetchInProgress || _pagingState.isLoading) {
          return;
        }
        setState(() {
          _pagingState = PagingState();
          _nextPage = 0;
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
            final infoLines = _entryInfoLines(item);
            return ListTile(
              leading: _selectionMode
                  ? Checkbox(
                      value: _selectedAccounts.contains(item),
                      onChanged: (_) => _toggleSelection(item),
                    )
                  : null,
              title: Text("${item.name ?? "No name"}, ${item.age}"),
              subtitle: Text(infoLines.join("\n")),
              isThreeLine: infoLines.length > 2,
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
          noMoreItemsIndicatorBuilder: (context) {
            final loaded = _pagingState.items?.length ?? 0;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "All loaded ($loaded accounts)",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return buildListReplacementMessageSimple(context, "No accounts found");
          },
        ),
      ),
    );
  }

  List<String> _entryInfoLines(AccountEntry item) {
    final lines = <String>[item.accountId.aid];

    final accountState = item.accountState;
    if (accountState != null) {
      lines.add("State: ${accountState.toUiString()}");
    }

    final accountOnline = item.accountOnline;
    if (accountOnline != null) {
      lines.add(accountOnline ? "Online" : "Offline");
    }

    final profileVisibility = item.profileVisibility;
    if (profileVisibility != null) {
      lines.add("Visibility: $profileVisibility");
    }

    final email = item.email;
    if (email != null) {
      lines.add(email);
    }

    final ipCountry = item.loginSessionIpCountry;
    if (ipCountry != null) {
      lines.add("IP country: $ipCountry");
    }

    final loginSession = item.loginSession;
    if (loginSession != null) {
      final parts = <String>[];
      final clientType = loginSession.clientType;
      if (clientType != null) {
        parts.add(clientType.toString());
      }
      final loginMethod = loginSession.loginMethod;
      if (loginMethod != null) {
        parts.add(loginMethod.toString());
      }
      final appAttestationType = loginSession.appAttestationType;
      if (appAttestationType != null) {
        parts.add(appAttestationType.toString());
      }
      final appAttestationFailed = loginSession.appAttestationFailed;
      if (appAttestationFailed != null) {
        parts.add(appAttestationFailed ? "attestation failed" : "attestation ok");
      }
      if (parts.isNotEmpty) {
        lines.add("Login: ${parts.join(", ")}");
      }
    }

    return lines;
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
