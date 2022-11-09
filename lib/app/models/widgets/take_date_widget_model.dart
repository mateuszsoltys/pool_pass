import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeDateWidget extends StatelessWidget {
  TakeDateWidget({
    Key? key,
    required this.pickedDate,
    required this.actualDate,
  }) : super(key: key);
  final DateTime pickedDate;
  final DateTime actualDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.blueAccent.shade700),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          const Text('DATA ZAKUPU'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('dd-MM-yyyy').format(pickedDate)),
              IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: actualDate,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2030),
                    );
                  },
                  icon: const Icon(Icons.calendar_month_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}
