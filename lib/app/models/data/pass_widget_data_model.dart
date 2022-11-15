// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'pass_widget_data_model.g.dart';

@HiveType(typeId: 0)
class PassWidgetDataModel extends HiveObject {
  @HiveField(0)
  final String passName;
  @HiveField(1)
  final int ticketsNumber;
  @HiveField(2)
  final DateTime passDate;

  PassWidgetDataModel({
    required this.passName,
    required this.ticketsNumber,
    required this.passDate,
  });
}
