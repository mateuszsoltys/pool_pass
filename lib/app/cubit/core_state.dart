// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'core_cubit.dart';

@immutable
class CoreState {
  final String dataBoxname;
  final String? passName;
  final int? ticketsNumber;
  final DateTime today;
  final DateTime pickedDate;
  final DateTime passValidity;
  final int monthPickerValue;

  CoreState({
    required this.dataBoxname,
    required this.passName,
    required this.ticketsNumber,
    required this.today,
    required this.pickedDate,
    required this.passValidity,
    required this.monthPickerValue,
  });

  CoreState copyWith({
    String? dataBoxname,
    String? passName,
    int? ticketsNumber,
    DateTime? today,
    DateTime? pickedDate,
    DateTime? passValidity,
    int? monthPickerValue,
  }) {
    return CoreState(
      dataBoxname: dataBoxname ?? this.dataBoxname,
      passName: passName ?? this.passName,
      ticketsNumber: ticketsNumber ?? this.ticketsNumber,
      today: today ?? this.today,
      pickedDate: pickedDate ?? this.pickedDate,
      passValidity: passValidity ?? this.passValidity,
      monthPickerValue: monthPickerValue ?? this.monthPickerValue,
    );
  }
}
