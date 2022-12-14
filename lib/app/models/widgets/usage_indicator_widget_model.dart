// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';

import 'package:poolpass/app/models/data/pass_widget_data_model.dart';
import 'package:poolpass/core/theme.dart';

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
    bool _expired = daysLeft == 'PO TERMINIE' ? true : false;
    CustomTheme _theme = CustomTheme();
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NDialog(
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
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10)),
                        margin: const EdgeInsets.only(right: 5),
                        color: Colors.blue,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        text: 'ODRZUĆ',
                        icon: const Icon(Ionicons.close_circle_outline),
                      ),
                      DialogButtonWidget(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10)),
                        margin: const EdgeInsets.only(left: 5),
                        color: Colors.red,
                        onTap: () {
                          deleteFunction.call(index);
                          Navigator.of(context).pop();
                        },
                        text: 'USUŃ',
                        icon: const Icon(Ionicons.alert_circle_outline),
                      ),
                    ],
                  );
                });
          },
          icon: Ionicons.trash,
          label: 'USUŃ KARNET',
          backgroundColor: Colors.transparent,
          foregroundColor: const Color.fromARGB(255, 255, 72, 59),
        )
      ]),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          decoration: BoxDecoration(
              color: _expired
                  ? _theme.expiredWidgetColor
                  : _theme.regularWidgetColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              CustomText(
                text: dataModel.passName,
                expired: _expired,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(children: [
                      CustomText(text: 'ważny do:', expired: _expired),
                      CustomText(text: formattedDate, expired: _expired)
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CustomText(text: 'pozostało dni:', expired: _expired),
                        CustomText(text: daysLeft, expired: _expired)
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
                      expired: _expired,
                      number: ticket.toString(),
                    )
                ],
              ),
            ],
          )),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key, required this.text, required this.expired, this.fontWeight})
      : super(key: key);
  final String text;
  final bool expired;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme();
    return Text(text.toUpperCase(),
        style: TextStyle(
            color: expired ? _theme.expiredTextColor : _theme.regularTextColor,
            fontWeight: fontWeight));
  }
}

class Ticket extends StatelessWidget {
  final String number;

  const Ticket({
    Key? key,
    required this.number,
    required this.expired,
  }) : super(key: key);
  final bool expired;
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme();
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color:
              expired ? _theme.expiredTicketColor : _theme.regularTicketColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: expired
                  ? _theme.expiredTicketTextColor
                  : _theme.regularTicketTextColor),
        ),
      ),
    );
  }
}
