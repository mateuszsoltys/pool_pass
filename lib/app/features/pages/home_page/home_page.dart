import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ndialog/ndialog.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/models/widgets/dialog_button_widget_model.dart';
import 'package:poolpass/app/models/widgets/empty_info_widget_model.dart';
import 'package:poolpass/app/models/widgets/usage_indicator_widget_model.dart';

import '../../../../core/database_boxes.dart';
import '../../../models/data/pass_widget_data_model.dart';
import '../../../models/widgets/new_pass_input_widget_model.dart';
import '../../../models/widgets/take_date_widget_model.dart';
import '../../../models/widgets/take_validity_widget_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Box<PassWidgetDataModel> passBox =
      Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, core) {
        return Scaffold(
          body: Center(
              child: core.passBoxDatas.isNotEmpty
                  ? ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        for (int index = 0;
                            index < core.passBoxDatas.length;
                            index++)
                          UsageIndicator(
                            substractFunction:
                                context.read<CoreCubit>().substractTicket,
                            deleteFunction:
                                context.read<CoreCubit>().deletePass,
                            index: index,
                            dataModel: core.passBoxDatas[index],
                            daysLeft: context
                                .read<CoreCubit>()
                                .setDaysLeft(core.passBoxDatas[index].passDate),
                          )
                      ],
                    )
                  : const EmptyInfoWidget()),
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
                    },
                    text: 'ODRZUĆ',
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  DialogButtonWidget(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    margin: const EdgeInsets.only(left: 5),
                    color: Colors.green,
                    onTap: () {
                      context.read<CoreCubit>().saveData(context);
                    },
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
