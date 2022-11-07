import 'package:flutter/material.dart';
import 'package:poolpass/app/features/pages/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Pool Pass',
      // Application theme data, you can set the colors for the application as
      // you want
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 66, 170, 255)),
      // A widget which will be started on application startup
      home: HomePage(),
    );
  }
}
