import 'package:app/localizations.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class ProfileVerificationStatusFlags {
  static const int faceVerifiedAny = 1;
  static const int faceVerifiedAll = 2;
}

const _PROFILE_VERIFICATION_STATUS_ICON = MaterialAttributeIcon(Icons.verified_user_outlined);

MaterialAttributeIcon profileVerificationStatusIcon() => _PROFILE_VERIFICATION_STATUS_ICON;

typedef _ProfileVerificationStatusOption = ((int, String), bool Function(VerificationConfig));

List<(int, String)> profileVerificationStatusOptions(
  BuildContext context, {
  required VerificationConfig verification,
}) {
  final options = <_ProfileVerificationStatusOption>[
    (
      (
        ProfileVerificationStatusFlags.faceVerifiedAny,
        context.strings.profile_filters_screen_profile_verification_status_filter_face_verified_any,
      ),
      (verification) => verification.face,
    ),
    (
      (
        ProfileVerificationStatusFlags.faceVerifiedAll,
        context.strings.profile_filters_screen_profile_verification_status_filter_face_verified_all,
      ),
      (verification) => verification.face,
    ),
  ];

  return options.where((option) => option.$2(verification)).map((option) => option.$1).toList();
}

class ProfileVerificationStatusFilterSection extends StatelessWidget {
  const ProfileVerificationStatusFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, clientFeaturesConfigState) {
        final config = clientFeaturesConfigState.verificationConfig();
        if (config == VerificationConfig()) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            _ProfileVerificationStatusFilter(verificationConfig: config),
          ],
        );
      },
    );
  }
}

class _ProfileVerificationStatusFilter extends StatelessWidget {
  final VerificationConfig verificationConfig;
  const _ProfileVerificationStatusFilter({required this.verificationConfig});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        final value = state.valueProfileVerificationStatusFilter()?.value;
        final options = profileVerificationStatusOptions(context, verification: verificationConfig);
        final selectedOptions = options.where((option) => (value ?? 0) & option.$1 != 0).toList();

        return InkWell(
          onTap: () {
            MyNavigator.pushLimited(context, ProfileVerificationFilterPage(verificationConfig));
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(4)),
                    ViewAttributeTitle(
                      context.strings.profile_filters_screen_profile_verification_status_filter,
                      icon: profileVerificationStatusIcon(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0, right: 8.0, bottom: 4.0),
                      child: selectedOptions.isEmpty
                          ? const SizedBox.shrink()
                          : Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: [
                                for (final option in selectedOptions) Chip(label: Text(option.$2)),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.edit_rounded, color: getIconButtonEnabledColor(context)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileVerificationFilterPage extends MyScreenPageLimited<()> {
  final VerificationConfig verificationConfig;
  ProfileVerificationFilterPage(this.verificationConfig)
    : super(builder: (_) => ProfileVerificationFilterScreen(verificationConfig));
}

class ProfileVerificationFilterScreen extends StatelessWidget {
  final VerificationConfig verificationConfig;
  const ProfileVerificationFilterScreen(this.verificationConfig, {super.key});

  @override
  Widget build(BuildContext context) {
    final options = profileVerificationStatusOptions(context, verification: verificationConfig);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile_filters_screen_profile_verification_status_filter),
      ),
      body: BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
        builder: (context, state) {
          final currentValue = state.valueProfileVerificationStatusFilter()?.value ?? 0;
          return ListView(
            children: [
              for (final option in options)
                CheckboxListTile(
                  title: Text(option.$2),
                  value: (currentValue & option.$1) != 0,
                  onChanged: (enabled) {
                    setValue(context, toggleBit(currentValue, option.$1, enabled == true));
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  int toggleBit(int value, int bit, bool enabled) {
    if (enabled) {
      return value | bit;
    } else {
      return value & ~bit;
    }
  }

  void setValue(BuildContext context, int value) {
    final ProfileVerificationStatusFilter? filter = value == 0
        ? null
        : ProfileVerificationStatusFilter(value: value);
    context.read<ProfileFiltersBloc>().add(SetProfileVerificationStatusFilter(filter));
  }
}
