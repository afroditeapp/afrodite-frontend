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

const _FACE_VERIFIED_ANY = 1;
const _FACE_VERIFIED_ALL = 2;

class ProfileVerificationStatusFilterSection extends StatelessWidget {
  const ProfileVerificationStatusFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, clientFeaturesConfigState) {
        if (clientFeaturesConfigState.config.profile?.verification == VerificationConfig()) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: const [Divider(), _ProfileVerificationStatusFilter()],
        );
      },
    );
  }
}

class _ProfileVerificationStatusFilter extends StatelessWidget {
  const _ProfileVerificationStatusFilter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        final value = state.valueProfileVerificationStatusFilter()?.value;
        final options = _profileVerificationFilterOptions(context);
        final selectedOptions = options.where((option) => (value ?? 0) & option.$1 != 0).toList();

        return InkWell(
          onTap: () {
            MyNavigator.pushLimited(context, ProfileVerificationFilterPage());
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
                      icon: const MaterialAttributeIcon(Icons.verified_user_outlined),
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

  List<(int, String)> _profileVerificationFilterOptions(BuildContext context) {
    return [
      (
        _FACE_VERIFIED_ANY,
        context.strings.profile_filters_screen_profile_verification_status_filter_face_verified_any,
      ),
      (
        _FACE_VERIFIED_ALL,
        context.strings.profile_filters_screen_profile_verification_status_filter_face_verified_all,
      ),
    ];
  }
}

class ProfileVerificationFilterPage extends MyScreenPageLimited<()> {
  ProfileVerificationFilterPage() : super(builder: (_) => const ProfileVerificationFilterScreen());
}

class ProfileVerificationFilterScreen extends StatelessWidget {
  const ProfileVerificationFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile_filters_screen_profile_verification_status_filter),
      ),
      body: BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
        builder: (context, state) {
          final currentValue = state.valueProfileVerificationStatusFilter()?.value ?? 0;
          return ListView(
            children: [
              CheckboxListTile(
                title: Text(
                  context
                      .strings
                      .profile_filters_screen_profile_verification_status_filter_face_verified_any,
                ),
                value: (currentValue & _FACE_VERIFIED_ANY) != 0,
                onChanged: (enabled) {
                  setValue(context, toggleBit(currentValue, _FACE_VERIFIED_ANY, enabled == true));
                },
              ),
              CheckboxListTile(
                title: Text(
                  context
                      .strings
                      .profile_filters_screen_profile_verification_status_filter_face_verified_all,
                ),
                value: (currentValue & _FACE_VERIFIED_ALL) != 0,
                onChanged: (enabled) {
                  setValue(context, toggleBit(currentValue, _FACE_VERIFIED_ALL, enabled == true));
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
