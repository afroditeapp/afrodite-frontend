import 'package:app/localizations.dart';
import 'package:app/logic/account/account_details.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account_details.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openAccountIdForSupport(BuildContext context) {
  MyNavigator.push(context, AccountIdForSupportPage());
}

class AccountIdForSupportPage extends MyScreenPage<()>
    with SimpleUrlParser<AccountIdForSupportPage> {
  AccountIdForSupportPage() : super(builder: (_) => const AccountIdForSupportScreen());

  @override
  AccountIdForSupportPage create() => AccountIdForSupportPage();
}

class AccountIdForSupportScreen extends StatelessWidget {
  const AccountIdForSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.account_id_for_support_screen_title)),
      body: BlocBuilder<AccountDetailsBloc, AccountDetailsBlocData>(
        builder: (context, state) {
          return content(context, state.email ?? context.strings.generic_error);
        },
      ),
    );
  }

  Widget content(BuildContext context, String email) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          hPad(
            Text(
              context.strings.account_id_for_support_screen_email_title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Padding(padding: EdgeInsets.all(4)),
          hPad(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(email, style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: context.strings.generic_copy,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: email));
                      showSnackBar(context.strings.generic_copied_to_clipboard);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          hPad(
            Text(
              context.strings.account_id_for_support_screen_info,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
