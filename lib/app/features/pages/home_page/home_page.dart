import 'package:flutter/material.dart';
import 'package:poolpass/app/models/widgets/usage_indicator_widget_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        UsageIndicator(
          passName: 'ajnc',
          tickets: 1,
          passDate: '22.12.2022',
          passRemainingTime: 'nie wiem',
        )
      ],
    )));
  }
}
