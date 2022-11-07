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
        UsageIndicator(passName: 'ajnc', tickets: 22)
      ],
    )));
  }
}
