import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/models/widgets/usage_indicator_widget_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, core) {
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
      },
    );
  }
}
