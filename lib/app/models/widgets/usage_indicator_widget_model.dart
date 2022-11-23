// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';

import 'package:poolpass/app/models/data/pass_widget_data_model.dart';

import 'dialog_button_widget_model.dart';

class UsageIndicator extends StatelessWidget {
  final PassWidgetDataModel dataModel;
  final String daysLeft;
  final Function substractFunction;
  final Function deleteFunction;
  final int index;

  const UsageIndicator({
    Key? key,
    required this.dataModel,
    required this.daysLeft,
    required this.substractFunction,
    required this.deleteFunction,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd-MM-yyyy').format(dataModel.passDate);
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
              onPressed: (cotext) {
                substractFunction.call(dataModel, index);
              },
              label: 'WEJŚCIE',
              icon: Ionicons.ticket,
              foregroundColor: Colors.amber,
              backgroundColor: Colors.transparent)
        ],
      ),
      endActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            NDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              title: const Text("USUWANIE KARNETU"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Próbujesz usunąć karnet: ${dataModel.passName}'),
                  const SizedBox(height: 5),
                  const Text('Tej operacji nie będzie można cofnąć')
                ],
              ),
              actions: <Widget>[
                DialogButtonWidget(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(10)),
                  margin: const EdgeInsets.only(right: 5),
                  color: Colors.blue,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: 'ODRZUĆ',
                  icon: const Icon(Icons.cancel_outlined),
                ),
                DialogButtonWidget(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(10)),
                  margin: const EdgeInsets.only(left: 5),
                  color: Colors.red,
                  onTap: () {
                    deleteFunction.call(index);
                    Navigator.of(context).pop();
                  },
                  text: 'USUŃ',
                  icon: const Icon(Icons.add),
                ),
              ],
            ).show(context);
          },
          icon: Ionicons.trash,
          label: 'USUŃ KARNET',
          backgroundColor: Colors.transparent,
          foregroundColor: Color.fromARGB(255, 255, 72, 59),
        )
      ]),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          decoration: const BoxDecoration(
              color: Color.fromARGB(141, 19, 55, 255),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text(
                dataModel.passName.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(children: [
                      const Text(
                        'WAŻNY DO:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.white),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        const Text('POZOSTAŁO DNI:',
                            style: TextStyle(color: Colors.white)),
                        Text(daysLeft,
                            style: const TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  for (int ticket = 1;
                      ticket <= dataModel.ticketsNumber;
                      ticket++)
                    Ticket(
                      number: ticket.toString(),
                    )
                ],
              ),
            ],
          )),
    );
  }
}

class Ticket extends StatelessWidget {
  final String number;

  const Ticket({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 3, 0, 167),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          number,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
