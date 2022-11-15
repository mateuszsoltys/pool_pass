import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poolpass/core/database_boxes.dart';

import '../models/data/pass_widget_data_model.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit()
      : super(CoreState(
            today: DateTime.now(),
            pickedDate: DateTime.now(),
            monthPickerValue: 6,
            passName: null,
            ticketsNumber: null,
            passValidity: DateTime.now(),
            dataBoxname: HiveBoxes.pass));

  Future<void> setDefault() async {
    emit(CoreState(
      dataBoxname: HiveBoxes.pass,
      today: DateTime.now(),
      pickedDate: DateTime.now(),
      monthPickerValue: 6,
      passName: null,
      ticketsNumber: null,
      passValidity: DateTime.now(),
    ));
  }

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

    if (_pickedDate != null && _pickedDate != state.pickedDate) {
      emit(state.copyWith(pickedDate: _pickedDate));
    }
  }

  Future<void> saveData() async {
    Box<PassWidgetDataModel> passBox =
        Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
    if (state.passName != null && state.ticketsNumber != null) {
      passBox.add(PassWidgetDataModel(
          passName: state.passName!,
          ticketsNumber: state.ticketsNumber!,
          passDate: state.passValidity));
    } else {
      null;
    }
  }
}
