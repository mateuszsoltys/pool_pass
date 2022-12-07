import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poolpass/app/app.dart';
import 'package:poolpass/core/database_boxes.dart';

import 'app/models/data/pass_widget_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PassWidgetDataModelAdapter());
  await Hive.openBox<PassWidgetDataModel>(HiveBoxes.pass);
  runApp(MyApp());
}
