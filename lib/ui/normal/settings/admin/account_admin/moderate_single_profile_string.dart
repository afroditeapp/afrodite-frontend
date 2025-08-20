import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class ModerateSingleProfileStringScreen extends StatefulWidget {
  final AccountId accountId;
  final ProfileStringModerationContentType contentType;
  const ModerateSingleProfileStringScreen({
    required this.accountId,
    required this.contentType,
    super.key,
  });

  @override
  State<ModerateSingleProfileStringScreen> createState() =>
      _ModerateSingleProfileStringScreenState();
}

class _ModerateSingleProfileStringScreenState extends State<ModerateSingleProfileStringScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;
  final chat = LoginRepository.getInstance().repositories.chat;

  final detailsController = TextEditingController();

  GetProfileStringState? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
        .profileAdmin((api) => api.getProfileStringState(widget.contentType, widget.accountId.aid))
        .ok();

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
      appBar: AppBar(title: Text("Moderate ${widget.contentType.adminUiText()}")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final info = data;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || info == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, data, state.permissions);
        },
      );
    }
  }

  Widget showData(BuildContext context, GetProfileStringState? data, Permissions myPermissions) {
    final profileStringData = data?.value;
    final String? profileString;
    if (profileStringData != null && profileStringData.isNotEmpty) {
      profileString = profileStringData;
    } else {
      profileString = null;
    }
    final rejectionReason = data?.moderationInfo?.rejectedReasonDetails.value;
    final state = data?.moderationInfo?.state;
    final accepted = switch (state) {
      ProfileStringModerationState.waitingBotOrHumanModeration ||
      ProfileStringModerationState.waitingHumanModeration => null,
      ProfileStringModerationState.rejectedByBot ||
      ProfileStringModerationState.rejectedByHuman => false,
      ProfileStringModerationState.acceptedByAllowlist ||
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
          if (profileString != null && state != null)
            hPad(
              profileStringModerating(
                context,
                profileString,
                rejectionReason ?? "",
                accepted,
                state,
              ),
            ),
          if (profileString == null) hPad(Text("No ${widget.contentType.adminUiText()}")),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Widget profileStringModerating(
    BuildContext context,
    String profileString,
    String rejectionReason,
    bool? accepted,
    ProfileStringModerationState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Text("Moderation state", style: Theme.of(context).textTheme.titleSmall),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(state.toString()),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(
          widget.contentType.adminUiTextFirstLetterUppercase(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(profileString),
        if (rejectionReason.isNotEmpty) const Padding(padding: EdgeInsets.all(8.0)),
        if (rejectionReason.isNotEmpty)
          Text("Rejection reason", style: Theme.of(context).textTheme.titleSmall),
        if (rejectionReason.isNotEmpty) const Padding(padding: EdgeInsets.all(8.0)),
        if (rejectionReason.isNotEmpty) Text(rejectionReason),
        if (accepted == true) const Padding(padding: EdgeInsets.all(8.0)),
        if (accepted == true)
          TextField(
            controller: detailsController,
            decoration: const InputDecoration(hintText: "Rejection reason"),
          ),
        const Padding(padding: EdgeInsets.all(8.0)),
        if (accepted == true)
          ElevatedButton(
            onPressed: () async {
              final details = ProfileStringModerationRejectedReasonDetails(
                value: detailsController.text.trim(),
              );
              final result = await showConfirmDialog(context, "Reject?", yesNoActions: true);
              if (result == true && context.mounted) {
                final result = await api.profileAdminAction(
                  (api) => api.postModerateProfileString(
                    PostModerateProfileString(
                      contentType: widget.contentType,
                      id: widget.accountId,
                      accept: false,
                      value: profileString,
                      rejectedDetails: details,
                    ),
                  ),
                );
                if (result.isErr()) {
                  showSnackBar(R.strings.generic_error);
                }
                await _refreshAfterAction();
              }
            },
            child: const Text("Reject"),
          ),
        if (accepted == false)
          ElevatedButton(
            onPressed: () async {
              final result = await showConfirmDialog(context, "Accept?", yesNoActions: true);
              if (result == true && context.mounted) {
                final result = await api.profileAdminAction(
                  (api) => api.postModerateProfileString(
                    PostModerateProfileString(
                      contentType: widget.contentType,
                      id: widget.accountId,
                      accept: true,
                      value: profileString,
                      rejectedDetails: ProfileStringModerationRejectedReasonDetails(value: ""),
                    ),
                  ),
                );
                if (result.isErr()) {
                  showSnackBar(R.strings.generic_error);
                }
                await _refreshAfterAction();
              }
            },
            child: const Text("Accept"),
          ),
      ],
    );
  }

  Future<void> _refreshAfterAction() async {
    await _getData();
    await profile.downloadProfileToDatabase(chat, widget.accountId);
  }
}
