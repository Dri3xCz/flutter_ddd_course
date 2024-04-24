
import 'package:clean_flutter_tdd_ddd/core/localization/presentation/widgets/LocalizationWidget.dart';
import 'package:flutter/material.dart';


class DrawerWithLocalization extends StatelessWidget {
  const DrawerWithLocalization({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(child: Placeholder()),
          Container(
            height: 60,
            child: LocalizationWidget(),
          ),
        ],
      ), 
    );
  }
}
