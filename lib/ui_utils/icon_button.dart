


import 'package:flutter/material.dart';

class IconWithIconButtonPadding extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const IconWithIconButtonPadding(this.icon, {
    super.key,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
