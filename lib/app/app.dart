import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolpass/app/cubit/core_cubit.dart';
import 'package:poolpass/app/features/pages/home_page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoreCubit()..start(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('pl')],
        title: 'Pool Pass',
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 66, 170, 255)),
        home: HomePage(),
      ),
    );
  }
}
