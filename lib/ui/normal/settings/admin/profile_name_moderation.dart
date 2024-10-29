import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/profile/admin/profile_name_moderation.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/admin/profile_name_moderation.dart';
import 'package:pihka_frontend/ui_utils/consts/animation.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

Future<void> openProfileNameModerationScreen(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ProfileNameModerationBloc(),
        lazy: false,
        child: ProfileNameModerationScreen(
          pageKey: pageKey,
        ),
      ),
    ),
    pageKey,
  );
}

class ProfileNameModerationScreen extends StatefulWidget {
  final PageKey pageKey;
  const ProfileNameModerationScreen({
    required this.pageKey,
    super.key,
  });

  @override
  State<ProfileNameModerationScreen> createState() => ProfileNameModerationScreenState();
}

class ProfileNameModerationScreenState extends State<ProfileNameModerationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ProfileNameModerationBloc, ProfileNameModerationData>(
            builder: (context, state) {
              final items = state.item?.values;
              if (state.selected.isEmpty && items != null) {
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    final r = await showConfirmDialog(
                      context,
                      "Accept all?",
                    );
                    if (r == true && context.mounted) {
                      context.read<ProfileNameModerationBloc>().add(
                        HandleList(items, true),
                      );
                    }
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<ProfileNameModerationBloc, ProfileNameModerationData>(
            builder: (context, state) {
              if (state.selected.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    final selected = state.selected.toList();
                    final String text;
                    if (selected.length > 1) {
                      text = "Accept ${selected.length} names?";
                    } else {
                      text = "Accept ${selected.length} name?";
                    }
                    final r = await showConfirmDialog(
                      context,
                      text,
                    );
                    if (r == true && context.mounted) {
                      context.read<ProfileNameModerationBloc>().add(
                        HandleList(selected, true),
                      );
                    }
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<ProfileNameModerationBloc, ProfileNameModerationData>(
            builder: (context, state) {
              if (state.selected.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.block),
                  onPressed: () async {
                    final selected = state.selected.toList();
                    final String text;
                    if (selected.length > 1) {
                      text = "Deny ${selected.length} names?";
                    } else {
                      text = "Deny ${selected.length} name?";
                    }
                    final r = await showConfirmDialog(
                      context,
                      text,
                    );
                    if (r == true && context.mounted) {
                      context.read<ProfileNameModerationBloc>().add(
                        HandleList(selected.toList(), false),
                      );
                    }
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
        title: Text(context.strings.moderate_profile_names_screen_title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<ProfileNameModerationBloc, ProfileNameModerationData>(
        builder: (context, state) {
          final item = state.item;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_error_occurred
            );
          } else if (item == null) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_not_found
            );
          } else {
            return viewItem(context, item, state.selected);
          }
        }
      ),
    );
  }

  Widget viewItem(
    BuildContext context,
    GetProfileNamePendingModerationList item,
    Set<ProfileNamePendingModeration> selected,
  ) {
    return ListView.builder(
      itemCount: item.values.length,
      itemBuilder: (context, index) {
        return Material(child: buildEntry(context, item.values[index], selected));
      },
    );
  }

  Widget buildEntry(
    BuildContext context,
    ProfileNamePendingModeration name,
    Set<ProfileNamePendingModeration> selected,
  ) {
    return ListTile(
      title: Text(name.name),
      onTap: () {
        context.read<ProfileNameModerationBloc>().add(
          UpdateSelectedStatus(name, !selected.contains(name))
        );
      },
      selectedColor: Theme.of(context).colorScheme.onPrimary,
      selectedTileColor: Theme.of(context).colorScheme.primary,
      selected: selected.contains(name),
    );
  }
}
