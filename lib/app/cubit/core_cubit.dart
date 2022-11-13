import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit()
      : super(CoreState(
          today: DateTime.now(),
          pickedDate: DateTime.now(),
          monthPickerValue: 6,
          passName: '',
          ticketsNumber: 0,
          passValidity: DateTime.now(),
        ));

  Future<void> setPassValidity() async {
    var date = state.pickedDate;
    var newDate =
        DateTime(date.year, date.month + state.monthPickerValue, date.day);
    emit(state.copyWith(passValidity: newDate));
  }

  Future<void> setMonthPickerValue(val) async {
    emit(state.copyWith(monthPickerValue: val));
  }

  Future<void> setPassName(val) async {
    emit(state.copyWith(passName: val));
  }

  Future<void> setPassNumberTickets(val) async {
    int _nuberTickets = int.parse(val);
    emit(state.copyWith(ticketsNumber: _nuberTickets));
  }

  Future<void> setNewDate(BuildContext context) async {
    DateTime _date = state.today;
    DateTime _firstDate = DateTime(_date.year - 2, _date.month, _date.day);
    DateTime _lastDate = DateTime(_date.year + 3, _date.month, _date.day);
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: state.pickedDate,
        firstDate: _firstDate,
        lastDate: _lastDate,
        locale: const Locale('pl'));

    if (_pickedDate != null && _pickedDate != _date) {
      emit(state.copyWith(pickedDate: _pickedDate));
    }
  }
}
