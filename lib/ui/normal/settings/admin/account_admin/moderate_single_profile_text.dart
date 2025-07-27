

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

class ModerateSingleProfileTextScreen extends StatefulWidget {
  final AccountId accountId;
  const ModerateSingleProfileTextScreen({
    required this.accountId,
    super.key,
  });

  @override
  State<ModerateSingleProfileTextScreen> createState() => _ModerateSingleProfileTextScreenState();
}

class _ModerateSingleProfileTextScreenState extends State<ModerateSingleProfileTextScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;
  final chat = LoginRepository.getInstance().repositories.chat;

  final detailsController = TextEditingController();

  GetProfileStringState? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .profileAdmin(
        (api) => api.getProfileStringState(
          ProfileStringModerationContentType.profileText,
          widget.accountId.aid,
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
        title: const Text("Moderate profile text"),
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

  Widget showData(BuildContext context, GetProfileStringState? data, Permissions myPermissions) {
    final profileTextData = data?.value;
    final String? profileText;
    if (profileTextData != null && profileTextData.isNotEmpty) {
      profileText = profileTextData;
    } else {
      profileText = null;
    }
    final state = data?.moderationInfo?.state;
    final rejectionReason = data?.moderationInfo?.rejectedReasonDetails.value;
    final accepted = switch (state) {
      ProfileStringModerationState.waitingBotOrHumanModeration ||
      ProfileStringModerationState.waitingHumanModeration => null,
      ProfileStringModerationState.rejectedByBot ||
      ProfileStringModerationState.rejectedByHuman => false,
      ProfileStringModerationState.acceptedByBot ||
      ProfileStringModerationState.acceptedByHuman => true,
      _ => null,
    };
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          if (profileText != null && state != null) hPad(profileTextModerating(context, profileText, rejectionReason, accepted, state)),
          if (profileText == null) hPad(const Text("No profile text")),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Widget profileTextModerating(
    BuildContext context,
    String profileText,
    String? rejectionReason,
    bool? accepted,
    ProfileStringModerationState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Text("Profile text moderation state", style: Theme.of(context).textTheme.titleSmall),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(state.toString()),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text("Profile text", style: Theme.of(context).textTheme.titleSmall),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(profileText),
        if (rejectionReason != null) const Padding(padding: EdgeInsets.all(8.0)),
        if (rejectionReason != null) Text("Rejection reason", style: Theme.of(context).textTheme.titleSmall),
        if (rejectionReason != null) const Padding(padding: EdgeInsets.all(8.0)),
        if (rejectionReason != null) Text(rejectionReason),
        if (accepted == true) const Padding(padding: EdgeInsets.all(8.0)),
        if (accepted == true) TextField(
          controller: detailsController,
          decoration: const InputDecoration(
            hintText: "Rejection reason",
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        if (accepted == true) ElevatedButton(
          onPressed: () async {
            final details = ProfileStringModerationRejectedReasonDetails(value: detailsController.text.trim());
            final result = await showConfirmDialog(context, "Reject?", yesNoActions: true);
            if (result == true && context.mounted) {
              final result = await api
                .profileAdminAction(
                  (api) => api.postModerateProfileString(
                    PostModerateProfileString(
                      contentType: ProfileStringModerationContentType.profileText,
                      id: widget.accountId,
                      accept: false,
                      value: profileText,
                      rejectedDetails: details,
                    )
                  ));
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error);
              }
              await _refreshAfterAction();
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
                  (api) => api.postModerateProfileString(
                    PostModerateProfileString(
                      contentType: ProfileStringModerationContentType.profileText,
                      id: widget.accountId,
                      accept: true,
                      value: profileText,
                      rejectedDetails: ProfileStringModerationRejectedReasonDetails(value: ""),
                    )
                  ));
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error);
              }
              await _refreshAfterAction();
            }
          },
          child: const Text("Accept"),
        )
      ],
    );
  }

  Future<void> _refreshAfterAction() async {
    await _getData();
    await profile.downloadProfileToDatabase(chat, widget.accountId);
  }
}
