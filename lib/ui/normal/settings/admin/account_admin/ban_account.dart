import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class BanAccountScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  BanAccountScreen(RepositoryInstances r, {required this.accountId, super.key}) : api = r.api;

  @override
  State<BanAccountScreen> createState() => _BanAccountScreenState();
}

class _BanAccountScreenState extends State<BanAccountScreen> {
  final banDaysTextController = TextEditingController();
  final banDetailsController = TextEditingController();

  GetAccountBanTimeResult? data;

  bool isLoading = true;
  bool isError = false;

  int? selectedBanSeconds;

  Future<void> _getData() async {
    final result = await widget.api
        .account((api) => api.getAccountBanTime(widget.accountId.aid))
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
      appBar: AppBar(title: const Text("Ban account")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final bannedInfo = data;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || bannedInfo == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, bannedInfo, state.permissions);
        },
      );
    }
  }

  Widget showData(
    BuildContext context,
    GetAccountBanTimeResult bannedInfo,
    Permissions myPermissions,
  ) {
    final bannedUntilUnixTime = bannedInfo.bannedUntil;
    final String? bannedUntil;
    if (bannedUntilUnixTime != null) {
      bannedUntil = fullTimeString(bannedUntilUnixTime.toUtcDateTime());
    } else {
      bannedUntil = null;
    }
    final banningReason = bannedInfo.reasonDetails.value;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          if (bannedUntil != null) hPad(Text("Banned until $bannedUntil")),
          if (bannedUntil == null) hPad(const Text("Not banned")),
          if (banningReason.isNotEmpty) const Padding(padding: EdgeInsets.all(8.0)),
          if (banningReason.isNotEmpty) hPad(Text("Banning reason: $banningReason")),
          const Padding(padding: EdgeInsets.all(8.0)),
          if (bannedUntil != null) hPad(unbanWidget(context)),
          if (bannedUntil == null) hPad(banWidget(context)),
          const Padding(padding: EdgeInsets.all(8.0)),
        ],
      ),
    );
  }

  Widget banWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        TextField(
          controller: banDaysTextController,
          decoration: const InputDecoration(hintText: "Days"),
          keyboardType: TextInputType.number,
          enableSuggestions: false,
          autocorrect: false,
          maxLength: 5,
          onChanged: (value) {
            final valueInt = int.tryParse(value);
            setState(() {
              selectedBanSeconds = (valueInt ?? 0) * 60 * 60 * 24;
            });
          },
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        TextField(
          controller: banDetailsController,
          decoration: const InputDecoration(hintText: "Ban reason"),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        bannedUntilTimePreview(),
        const Padding(padding: EdgeInsets.all(8.0)),
        ElevatedButton(
          onPressed: selectedBanSeconds != null
              ? () async {
                  final seconds = selectedBanSeconds!;
                  final banDetails = AccountBanReasonDetails(
                    value: banDetailsController.text.trim(),
                  );

                  final result = await showConfirmDialog(context, "Ban?", yesNoActions: true);
                  if (result == true && context.mounted) {
                    final result = await widget.api.accountAdminAction(
                      (api) => api.postSetBanState(
                        SetAccountBanState(
                          account: widget.accountId,
                          banUntil: UtcDateTime.now().toUnixTime()..addSeconds(seconds),
                          reasonDetails: banDetails,
                        ),
                      ),
                    );
                    if (result.isErr()) {
                      showSnackBar(R.strings.generic_error);
                    }
                    await _getData();
                  }
                }
              : null,
          child: const Text("Ban"),
        ),
      ],
    );
  }

  Widget unbanWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, "Unban?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await widget.api.accountAdminAction(
            (api) => api.postSetBanState(
              SetAccountBanState(
                account: widget.accountId,
                reasonDetails: AccountBanReasonDetails(value: ""),
              ),
            ),
          );
          if (result.isErr()) {
            showSnackBar(R.strings.generic_error);
          }
          await _getData();
        }
      },
      child: const Text("Unban"),
    );
  }

  Widget bannedUntilTimePreview() {
    final seconds = selectedBanSeconds;
    if (seconds == null) {
      return const Text("");
    }

    final time = UtcDateTime.now().add(Duration(seconds: seconds));
    final timeString = fullTimeString(time);
    return Text("Banned until: $timeString");
  }
}
