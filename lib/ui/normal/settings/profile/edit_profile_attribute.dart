import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/ui_utils/attribute/widgets/select_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:app/ui_utils/app_bar/search.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';

class EditProfileAttributeScreen extends StatefulWidget {
  final AttributeAndState a;
  const EditProfileAttributeScreen({required this.a, super.key});

  @override
  State<EditProfileAttributeScreen> createState() => _EditProfileAttributeScreenState();
}

class _EditProfileAttributeScreenState extends State<EditProfileAttributeScreen> {
  bool searchPossible = false;
  late AppBarSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchPossible =
        widget.a.attribute().apiAttribute().mode == AttributeMode.oneLevel ||
        widget.a.attribute().apiAttribute().mode == AttributeMode.twoLevel;
    searchController = AppBarSearchController(onChanged: () => setState(() {}));
  }

  bool invalidSelection(EditMyProfileData data) {
    for (final updateValue in data.attributeIdAndStateMap.values) {
      if (updateValue.id == widget.a.attribute().apiAttribute().id) {
        final answer = updateValue.v.firstOrNull;
        return widget.a.attribute().apiAttribute().required_ && (answer == null || answer == 0);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(
      builder: (context, state) {
        final currentSelectionIsInvalid = invalidSelection(state);

        return PopScope(
          canPop: !currentSelectionIsInvalid,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              return;
            }
            showSnackBar(context.strings.edit_attribute_value_screen_one_value_must_be_selected);
          },
          child: Scaffold(
            appBar: AppBarWithSearch(
              controller: searchController,
              searchPossible: searchPossible,
              title: Text(context.strings.edit_profile_screen_title),
              searchHintText: context.strings.edit_attribute_value_screen_search_placeholder_text,
            ),
            body: edit(context, currentSelectionIsInvalid),
          ),
        );
      },
    );
  }

  Widget edit(BuildContext context, bool invalidSelection) {
    final String? filterValue;
    if (searchController.searchActive) {
      final processedFilter = searchController.searchController.text.trim().toLowerCase();
      if (processedFilter.isEmpty) {
        filterValue = null;
      } else {
        filterValue = processedFilter;
      }
    } else {
      filterValue = null;
    }

    return SelectAttributeValue(
      attribute: widget.a.attribute(),
      initialStateBuilder: () => SelectAttributeValueStorage.selected(widget.a.state.copy()),
      onChanged: (state) => context.read<EditMyProfileBloc>().add(
        NewAttributeValue(state.selected.toAttributeValueUpdate(widget.a.attribute())),
      ),
      firstListItem: EditAttributeTitle(a: widget.a.attribute()),
      lastListItem: invalidSelection
          ? Padding(
              padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
              child: Text(context.strings.edit_attribute_value_screen_one_value_must_be_selected),
            )
          : null,
      filterText: filterValue,
    );
  }
}

class EditAttributeTitle extends StatelessWidget {
  final UiAttribute a;
  const EditAttributeTitle({required this.a, super.key});

  @override
  Widget build(BuildContext context) {
    return questionTitle(context, a);
  }

  Widget questionTitle(BuildContext context, UiAttribute attribute) {
    final text = Text(attribute.uiName(), style: Theme.of(context).textTheme.bodyLarge);
    return Padding(padding: const EdgeInsets.all(INITIAL_SETUP_PADDING), child: text);
  }
}
