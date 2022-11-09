// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TakeValidityWidgetModel extends StatelessWidget {
  const TakeValidityWidgetModel({
    Key? key,
    required this.pickerValue,
    required this.onChanged,
  }) : super(key: key);
  final int pickerValue;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.blueAccent.shade700),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          const Text('WAŻNOŚĆ KARNETU'),
          NumberPicker(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(141, 94, 152, 190),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              itemWidth: 30,
              axis: Axis.horizontal,
              minValue: 1,
              step: 1,
              maxValue: 24,
              value: pickerValue,
              onChanged: (val) {
                onChanged.call(val);
              }),
          const Text('[MC]')
        ],
      ),
    );
  }
}
