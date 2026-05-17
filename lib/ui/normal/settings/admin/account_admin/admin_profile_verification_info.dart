import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AdminProfileVerificationInfoPage extends MyScreenPageLimited<()> {
  AdminProfileVerificationInfoPage(
    RepositoryInstances r,
    AccountId accountId, {
    required String currentName,
    required int currentAge,
  }) : super(
         builder: (_) => AdminProfileVerificationInfoScreen(
           r,
           accountId,
           currentName: currentName,
           currentAge: currentAge,
         ),
       );
}

class AdminProfileVerificationInfoScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  final String currentName;
  final int currentAge;
  AdminProfileVerificationInfoScreen(
    RepositoryInstances r,
    this.accountId, {
    required this.currentName,
    required this.currentAge,
    super.key,
  }) : api = r.api;

  @override
  State<AdminProfileVerificationInfoScreen> createState() =>
      _AdminProfileVerificationInfoScreenState();
}

class _AdminProfileVerificationInfoScreenState extends State<AdminProfileVerificationInfoScreen> {
  ProfileAgeRangeVerificationAdminInfo? ageRangeInfo;
  ProfileNameVerificationAdminInfo? nameInfo;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final ageRangeResult = await widget.api
        .profileAdmin((api) => api.getProfileAgeRangeVerificationAdminInfo(widget.accountId.aid))
        .ok();

    final nameResult = await widget.api
        .profileAdmin((api) => api.getProfileNameVerificationAdminInfo(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (ageRangeResult == null || nameResult == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        isError = false;
        ageRangeInfo = ageRangeResult;
        nameInfo = nameResult;
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
      appBar: AppBar(title: const Text("Profile verification info")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final ageInfo = ageRangeInfo;
    final pNameInfo = nameInfo;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || ageInfo == null || pNameInfo == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return Align(
            alignment: AlignmentGeometry.topCenter,
            child: showData(context, ageInfo, pNameInfo, state.permissions),
          );
        },
      );
    }
  }

  Widget showData(
    BuildContext context,
    ProfileAgeRangeVerificationAdminInfo ageInfo,
    ProfileNameVerificationAdminInfo nameInfo,
    Permissions permissions,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(Text("Name: ${widget.currentName}", textAlign: TextAlign.center)),
          const Padding(padding: EdgeInsets.only(top: 4)),
          hPad(Text("Age: ${widget.currentAge}", textAlign: TextAlign.center)),
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(
            Text(
              _verificationText(
                "Profile age range",
                ageInfo.profileAgeRangeVerified,
                ageInfo.profileAgeRangeVerifiedManual,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (permissions.adminEditProfileAgeRangeVerifiedValue)
            const Padding(padding: EdgeInsets.only(top: 8)),
          if (permissions.adminEditProfileAgeRangeVerifiedValue)
            _verificationButtons(
              context,
              label: "age range",
              currentManualValue: ageInfo.profileAgeRangeVerifiedManual,
              onChange: _changeProfileAgeRangeVerifiedValue,
            ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(
            Text(
              _verificationText(
                "Profile name",
                nameInfo.profileNameVerified,
                nameInfo.profileNameVerifiedManual,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (permissions.adminEditProfileNameVerifiedValue)
            const Padding(padding: EdgeInsets.only(top: 8)),
          if (permissions.adminEditProfileNameVerifiedValue)
            _verificationButtons(
              context,
              label: "name",
              currentManualValue: nameInfo.profileNameVerifiedManual,
              onChange: _changeProfileNameVerifiedValue,
            ),
          const Padding(padding: EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }

  String _verificationText(String itemName, bool? autoValue, bool? manualValue) {
    if (manualValue != null) {
      return manualValue ? "$itemName verified (manual)" : "$itemName not verified (manual)";
    }

    if (autoValue != null) {
      return autoValue ? "$itemName verified (auto)" : "$itemName not verified (auto)";
    }

    return "$itemName verification pending";
  }

  Widget _verificationButtons(
    BuildContext context, {
    required String label,
    required bool? currentManualValue,
    required Future<void> Function(bool?) onChange,
  }) {
    final List<Widget> buttons = [];

    if (currentManualValue != true) {
      buttons.add(
        _createVerificationChangeButton(context, "Verify $label", "Verify $label?", true, onChange),
      );
    }

    if (currentManualValue != false) {
      buttons.add(
        _createVerificationChangeButton(
          context,
          "Unverify $label",
          "Unverify $label?",
          false,
          onChange,
        ),
      );
    }

    if (currentManualValue != null) {
      buttons.add(
        _createVerificationChangeButton(
          context,
          "Clear $label verification override",
          "Clear $label verification override?",
          null,
          onChange,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final button in buttons) ...[button, const Padding(padding: EdgeInsets.only(top: 8))],
      ],
    );
  }

  Widget _createVerificationChangeButton(
    BuildContext context,
    String buttonText,
    String dialogTitle,
    bool? value,
    Future<void> Function(bool?) onChange,
  ) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, dialogTitle, yesNoActions: true);
        if (result == true) {
          await onChange(value);
        }
      },
      child: Text(buttonText),
    );
  }

  Future<void> _changeProfileAgeRangeVerifiedValue(bool? value) async {
    final result = await widget.api.profileAdminAction(
      (api) => api.postProfileAgeRangeVerifiedValue(
        PostProfileAgeRangeVerifiedValue(
          accountId: widget.accountId,
          currentProfileAge: widget.currentAge,
          value: value,
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    await _getData();
  }

  Future<void> _changeProfileNameVerifiedValue(bool? value) async {
    final result = await widget.api.profileAdminAction(
      (api) => api.postProfileNameVerifiedValue(
        PostProfileNameVerifiedValue(
          accountId: widget.accountId,
          currentProfileName: widget.currentName,
          value: value,
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    await _getData();
  }
}
