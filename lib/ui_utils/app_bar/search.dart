

import 'package:flutter/material.dart';

class AppBarSearchController {
  TextEditingController searchController = TextEditingController();
  bool searchActive = false;
  void Function()? onChanged;

  AppBarSearchController({this.onChanged});
}

class AppBarWithSearch extends StatefulWidget implements PreferredSizeWidget {
  final AppBarSearchController controller;
  final bool searchPossible;
  final Widget? title;
  final String? searchHintText;
  const AppBarWithSearch({
    required this.controller,
    this.searchPossible = false,
    this.title,
    this.searchHintText,
    super.key
  });

  @override
  State<AppBarWithSearch> createState() => _AppBarWithSearchState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> actions;
    final Widget? title;
    if (widget.searchPossible) {
      actions = [
        IconButton(
          icon: Icon(widget.controller.searchActive ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              if (widget.controller.searchActive) {
                widget.controller.searchController.clear();
              }
              widget.controller.searchActive = !widget.controller.searchActive;
            });
          },
        ),
      ];
      if (widget.controller.searchActive) {
        title = TextField(
          controller: widget.controller.searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: widget.searchHintText,
          ),
          onChanged: (value) {
            widget.controller.onChanged?.call();
          },
        );
      } else {
        title = widget.title;
      }
    } else {
      actions = [];
      title = widget.title;
    }

    return AppBar(
      title: title,
      actions: actions,
    );
  }
}
