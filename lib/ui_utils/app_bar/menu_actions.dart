


import 'package:flutter/material.dart';

Widget menuActions(List<MenuItemButton> actions) {
  return MenuAnchor(
    builder: (context, controller, child) {
      return IconButton(
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: const Icon(Icons.more_vert),
      );
    },
    menuChildren: actions
  );
}
