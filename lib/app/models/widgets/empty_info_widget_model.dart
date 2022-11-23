import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EmptyInfoWidget extends StatelessWidget {
  const EmptyInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.amber;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Icon(
                Ionicons.ticket,
                color: color,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'DODAJ SWÓJ KARNET',
                style: TextStyle(color: color, fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
