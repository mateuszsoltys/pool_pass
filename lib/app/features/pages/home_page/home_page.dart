import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/models/widgets/dialog_button_widget_model.dart';
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
        List<PassWidgetDataModel> widgetsList = core.passBoxDatas;
        return Scaffold(
          body: Center(
              child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              for (int index = 0; index < widgetsList.length; index++)
                Slidable(
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (cotext) {
                            context
                                .read<CoreCubit>()
                                .substractTicket(widgetsList[index], index);
                          },
                          label: 'WEJŚCIE',
                          icon: Ionicons.ticket,
                          backgroundColor: Colors.transparent)
                    ],
                  ),
                  endActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<CoreCubit>().deletePass(index);
                      },
                      icon: Ionicons.trash,
                      label: 'USUŃ KARNET',
                      backgroundColor: Colors.transparent,
                    )
                  ]),
                  child: UsageIndicator(
                    dataModel: widgetsList[index],
                    daysLeft: context
                        .read<CoreCubit>()
                        .setDaysLeft(widgetsList[index].passDate),
                  ),
                ),
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
