import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AssociationMembershipRegistryPage extends MyScreenPageLimited<()> {
  AssociationMembershipRegistryPage(RepositoryInstances r)
    : super(builder: (_) => AssociationMembershipRegistryScreen(r.api));
}

class AssociationMembershipRegistryScreen extends StatefulWidget {
  final ApiManager api;
  const AssociationMembershipRegistryScreen(this.api, {super.key});

  @override
  State<AssociationMembershipRegistryScreen> createState() =>
      _AssociationMembershipRegistryScreenState();
}

class _AssociationMembershipRegistryScreenState extends State<AssociationMembershipRegistryScreen> {
  PagingState<int, AssociationMember> _pagingState = PagingState();

  void updatePagingState(
    PagingState<int, AssociationMember> Function(PagingState<int, AssociationMember>) action,
  ) {
    if (!mounted) {
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

    final page = _pagingState.currentPageNumber();
    final data = await widget.api
        .accountAdmin(
          (api) => api.postGetAssociationMembersPage(GetAssociationMembersPage(page: page)),
        )
        .ok();

    if (!mounted) return;

    if (data == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    updatePagingState((s) => s.copyAndAdd(data.entries));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Association membership registry")),
      body: RefreshIndicator(
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
          builderDelegate: PagedChildBuilderDelegate<AssociationMember>(
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return ListTile(
                title: Text(item.fullName ?? item.aidMember.aid),
                subtitle: Text(
                  [
                    if (item.domicile != null) item.domicile!,
                    if (item.email != null) item.email!,
                  ].join(' · '),
                ),
                onTap: () {
                  getAgeAndNameAndShowAdminSettings(context, widget.api, item.aidMember);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
