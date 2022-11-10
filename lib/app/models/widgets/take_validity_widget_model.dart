// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';

class TakeValidityWidgetModel extends StatelessWidget {
  const TakeValidityWidgetModel({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, core) {
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
                  value: core.monthPickerValue,
                  onChanged: (val) {
                    onChanged.call(val);
                  }),
              const Text('[MC]')
            ],
          ),
        );
      },
    );
  }
}
