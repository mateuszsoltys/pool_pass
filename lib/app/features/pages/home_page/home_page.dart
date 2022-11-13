// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/models/widgets/dialog_button_widget_model.dart';
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
              print('stan passName: ${core.passName}');
              print('stan ticketsy: ${core.ticketsNumber}');
              print('stan month: ${core.monthPickerValue}');
              print('stan date: ${core.pickedDate}');
              NDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: const Text("NOWY KARNET"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NewPassInputWidget(
                      initialValue: core.passName ?? '',
                      onChanged: context.read<CoreCubit>().setPassName,
                      label: 'nazwa',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 2),
                    NewPassInputWidget(
                        initialValue: core.ticketsNumber == null
                            ? ''
                            : core.ticketsNumber.toString(),
                        onChanged:
                            context.read<CoreCubit>().setPassNumberTickets,
                        label: 'ilość wejść',
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 2),
                    TakeDateWidget(
                        setDate: context.read<CoreCubit>().setNewDate),
                    const SizedBox(height: 2),
                    TakeValidityWidgetModel(
                        onChanged:
                            context.read<CoreCubit>().setMonthPickerValue)
                  ],
                ),
                actions: <Widget>[
                  DialogButtonWidget(
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(10)),
                    margin: const EdgeInsets.only(right: 5),
                    color: Colors.red,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<CoreCubit>().setDefault();
                      print('stan close passName: ${core.passName}');
                      print('stan close date: ${core.pickedDate}');
                    },
                    text: 'ODRZUĆ',
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  DialogButtonWidget(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    margin: const EdgeInsets.only(left: 5),
                    color: Colors.green,
                    onTap: () {},
                    text: 'DODAJ',
                    icon: const Icon(Icons.add),
                  ),
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
