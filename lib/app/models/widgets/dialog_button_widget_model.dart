// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DialogButtonWidget extends StatelessWidget {
  const DialogButtonWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.borderRadius,
    required this.margin,
  }) : super(key: key);

  final Color color;
  final Icon icon;
  final String text;
  final Function onTap;
  final BorderRadius borderRadius;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 2),
            Text(text),
          ],
        ),
      ),
    );
  }
}
