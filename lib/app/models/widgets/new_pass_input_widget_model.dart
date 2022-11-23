// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poolpass/app/cubit/core_cubit.dart';

class NewPassInputWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function onChanged;
  final String initialValue;
  final TextInputFormatter format;
  NewPassInputWidget({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.onChanged,
    required this.initialValue,
    required this.format,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, core) {
        return SizedBox(
          width: 200,
          child: TextFormField(
            inputFormatters: [format],
            initialValue: initialValue,
            onChanged: (val) {
              onChanged.call(val);
            },
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: Colors.blueAccent.shade700),
                  borderRadius: BorderRadius.circular(10)),
              labelText: label.toUpperCase(),
            ),
          ),
        );
      },
    );
  }
}
