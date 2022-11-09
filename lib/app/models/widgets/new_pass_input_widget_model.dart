// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NewPassInputWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;

  NewPassInputWidget({
    Key? key,
    required this.label,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextFormField(
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
  }
}
