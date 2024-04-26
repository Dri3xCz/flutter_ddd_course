import 'package:flutter/material.dart';


class SettingsDrawer extends StatelessWidget {
  final List<Widget> mainWidgets;
  final Widget bottomWidget;

  const SettingsDrawer({
    super.key, 
    required this.mainWidgets,
    required this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: mainWidgets,
            ),
          ),
          Container(
            height: 60,
            child: bottomWidget,
          ),
        ],
      ), 
    );
  }
}
