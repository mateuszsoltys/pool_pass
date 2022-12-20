// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:poolpass/app/cubit/core_cubit.dart';

class TakeDateWidget extends StatelessWidget {
  TakeDateWidget({
    Key? key,
    required this.setDate,
  }) : super(key: key);
  final Function setDate;

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
              Text('DATA ZAKUPU', style: GoogleFonts.ibmPlexMono()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('dd-MM-yyyy').format(core.pickedDate)),
                  IconButton(
                      onPressed: () {
                        setDate.call(context);
                      },
                      icon: const Icon(Icons.calendar_month_outlined)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
