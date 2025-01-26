

import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class ModerateSingleProfileNameScreen extends StatefulWidget {
  final AccountId accountId;
  const ModerateSingleProfileNameScreen({
    required this.accountId,
    super.key,
  });

  @override
  State<ModerateSingleProfileNameScreen> createState() => _ModerateSingleProfileNameScreenState();
}

class _ModerateSingleProfileNameScreenState extends State<ModerateSingleProfileNameScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  GetProfileNameState? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .profileAdmin(
        (api) => api.getProfileNameState(
          widget.accountId.aid
        )).ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moderate profile name"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final info = data;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError || info == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, data, state.permissions);
        }
      );
    }
  }

  Widget showData(BuildContext context, GetProfileNameState? data, Permissions myPermissions) {
    final profileNameData = data?.name;
    final String? profileName;
    if (profileNameData != null && profileNameData.isNotEmpty) {
      profileName = profileNameData;
    } else {
      profileName = null;
    }
    final state = data?.state;
    final accepted = switch (data?.state) {
      ProfileNameModerationState.empty ||
      ProfileNameModerationState.waitingBotOrHumanModeration ||
      ProfileNameModerationState.waitingHumanModeration => null,
      ProfileNameModerationState.rejectedByBot ||
      ProfileNameModerationState.rejectedByHuman => false,
      ProfileNameModerationState.acceptedUsingAllowlist ||
      ProfileNameModerationState.acceptedByBot ||
      ProfileNameModerationState.acceptedByHuman => true,
      _ => null,
    };
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          if (profileName != null && state != null) hPad(profileTextModerating(context, profileName, accepted, state)),
          if (profileName == null) hPad(const Text("No profile name")),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Widget profileTextModerating(
    BuildContext context,
    String profileName,
    bool? accepted,
    ProfileNameModerationState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Text("Profile name moderation state", style: Theme.of(context).textTheme.titleSmall),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(state.toString()),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text("Profile name", style: Theme.of(context).textTheme.titleSmall),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(profileName),
        const Padding(padding: EdgeInsets.all(8.0)),
        if (accepted == true) ElevatedButton(
          onPressed: () async {
            final result = await showConfirmDialog(context, "Reject?", yesNoActions: true);
            if (result == true && context.mounted) {
              final result = await api
                .profileAdminAction(
                  (api) => api.postModerateProfileName(
                    PostModerateProfileName(
                      id: widget.accountId,
                      accept: false,
                      name: profileName,
                    )
                  ));
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error);
              }
              await _getData();
            }
          },
          child: const Text("Reject"),
        ),
      if (accepted == false) ElevatedButton(
          onPressed: () async {
            final result = await showConfirmDialog(context, "Accept?", yesNoActions: true);
            if (result == true && context.mounted) {
              final result = await api
                .profileAdminAction(
                  (api) => api.postModerateProfileName(
                    PostModerateProfileName(
                      id: widget.accountId,
                      accept: true,
                      name: profileName,
                    )
                  ));
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error);
              }
              await _getData();
            }
          },
          child: const Text("Accept"),
        )
      ],
    );
  }
}
