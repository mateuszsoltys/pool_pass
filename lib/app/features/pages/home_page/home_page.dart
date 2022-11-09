// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/models/widgets/usage_indicator_widget_model.dart';
import '../../../models/widgets/new_pass_input_widget_model.dart';
import '../../../models/widgets/take_date_widget_model.dart';
import '../../../models/widgets/take_validity_widget_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, core) {
        return Scaffold(
          body: Center(
              child: ListView(
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
          )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: (() {
              NDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: const Text("NOWY KARNET"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NewPassInputWidget(
                      label: 'nazwa',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 2),
                    NewPassInputWidget(
                        label: 'ilość wejść',
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 2),
                    TakeDateWidget(
                        actualDate: core.today, pickedDate: core.pickedDate),
                    const SizedBox(height: 2),
                    TakeValidityWidgetModel(
                        pickerValue: core.monthPickerValue,
                        onChanged:
                            context.read<CoreCubit>().setMonthPickerValue)
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      child: Text("Okay"),
                      onPressed: () => Navigator.pop(context)),
                  TextButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context)),
                ],
              ).show(context);
            }),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
