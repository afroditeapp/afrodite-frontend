

import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class BanAccountScreen extends StatefulWidget {
  final ProfileEntry entry;
  const BanAccountScreen({
    required this.entry,
    super.key,
  });

  @override
  State<BanAccountScreen> createState() => _BanAccountScreenState();
}

class _BanAccountScreenState extends State<BanAccountScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  final banDaysTextController = TextEditingController();
  final banDetailsController = TextEditingController();

  bool? banned;

  bool isLoading = true;
  bool isError = false;

  int? selectedBanSeconds;

  Future<void> _getData() async {
    final result = await api
      .accountAdmin(
        (api) => api.getAccountStateAdmin(widget.entry.uuid.aid)
      ).ok();

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
        banned = result.state.banned;
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
        title: const Text("Ban account"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final bannedInfo = banned;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError || bannedInfo == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return showData(context, bannedInfo, state.permissions);
        }
      );
    }
  }

  Widget showData(BuildContext context, bool bannedInfo, Permissions myPermissions) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          if (bannedInfo) hPad(const Text("Banned")),
          if (!bannedInfo) hPad(const Text("Not banned")),
          const Padding(padding: EdgeInsets.all(8.0)),
          if (bannedInfo) hPad(unbanWidget(context)),
          if (!bannedInfo) hPad(banWidget(context)),
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
          decoration: const InputDecoration(
            hintText: "Days",
          ),
          keyboardType: TextInputType.number,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (value) {
            final valueInt = int.tryParse(value);
            setState(() {
              selectedBanSeconds = valueInt ?? 0;
            });
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        TextField(
          controller: banDetailsController,
          decoration: const InputDecoration(
            hintText: "Ban reason",
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        ElevatedButton(
          onPressed: selectedBanSeconds != null ? () async {
            final seconds = selectedBanSeconds!;
            final banReason = banDetailsController.text.trim();
            final AccountBanReasonDetails? banDetails;
            if (banReason.isNotEmpty) {
              banDetails = AccountBanReasonDetails(value: banReason);
            } else {
              banDetails = null;
            }

            final result = await showConfirmDialog(context, "Ban?", yesNoActions: true);
            if (result == true && context.mounted) {
              final result = await api
                .accountAdminAction(
                  (api) => api.postSetBanState(
                    SetAccountBanState(
                      account: widget.entry.uuid,
                      banUntil: UtcDateTime.now().toUnixTime()..addSeconds(seconds),
                      reasonDetails: banDetails,
                    ),
                  )
                );
              if (result.isErr()) {
                showSnackBar(R.strings.generic_error);
              }
              await _getData();
            }
          } : null,
          child: const Text("Ban"),
        )
      ],
    );
  }

  Widget unbanWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(context, "Unban?", yesNoActions: true);
        if (result == true && context.mounted) {
          final result = await api
            .accountAdminAction(
              (api) => api.postSetBanState(
                SetAccountBanState(
                  account: widget.entry.uuid,
                ),
              )
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
}
