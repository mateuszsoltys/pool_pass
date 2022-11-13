// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../data/usage_indicator_data_model.dart';

class UsageIndicator extends StatelessWidget {
  final UsageIndicatorDataModel dataModel;

  const UsageIndicator({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 20, right: 20),
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
                Text(
                  'WAŻNY DO: ${dataModel.passDate}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text('POZOSTAŁO: ${dataModel.passRemainingTime}',
                    style: const TextStyle(color: Colors.white))
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (int ticket = 1; ticket <= dataModel.tickets; ticket++)
                  Ticket(
                    number: ticket.toString(),
                  )
              ],
            ),
          ],
        ));
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
