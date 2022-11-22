import 'dart:math';

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
            dataBoxname: HiveBoxes.pass,
            passBoxDatas: []));

  Future<void> setDefault() async {
    emit(CoreState(
      dataBoxname: HiveBoxes.pass,
      today: DateTime.now(),
      pickedDate: DateTime.now(),
      monthPickerValue: 6,
      passName: null,
      ticketsNumber: null,
      passValidity: DateTime.now(),
      passBoxDatas: [],
    ));
    readPassBox();
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

  Future<void> saveData(BuildContext context) async {
    Box<PassWidgetDataModel> passBox =
        Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
    setPassValidity();
    if (state.passName != null && state.ticketsNumber != null) {
      await passBox.add(PassWidgetDataModel(
          passName: state.passName!,
          ticketsNumber: state.ticketsNumber!,
          passDate: state.passValidity));
      setDefault();
      Navigator.of(context).pop();
    } else {
      null;
    }
  }

  Future<List<PassWidgetDataModel>?> readPassBox() async {
    int index = 0;
    Box<PassWidgetDataModel> passBox =
        Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
    final passDatas = await passBox.values.map((e) {
      index++;
      return PassWidgetDataModel(
          passName: e.passName,
          ticketsNumber: e.ticketsNumber,
          passDate: e.passDate);
    }).toList();

    emit(state.copyWith(passBoxDatas: passDatas));
  }

  String setDaysLeft(DateTime passDate) {
    DateTime _today = state.today;
    int _daysLeft = DateUtils.dateOnly(passDate)
        .difference(DateUtils.dateOnly(_today))
        .inDays;
    if (_daysLeft > 0) {
      return _daysLeft.toString();
    }
    if (_daysLeft == 0) {
      return 'DZISIAJ!';
    }
    if (_daysLeft < 0) {
      return 'PO TERMINIE';
    }
    return '';
  }

  Future<void> start() async {
    readPassBox();
  }

  Future<void> substractTicket(PassWidgetDataModel data, int index) async {
    Box<PassWidgetDataModel> passBox =
        Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
    int _newValTickets = data.ticketsNumber - 1;

    passBox.putAt(
        index,
        PassWidgetDataModel(
            passName: data.passName,
            ticketsNumber: _newValTickets,
            passDate: data.passDate));
    if (_newValTickets == 0) {
      deletePass(index);
    }
    readPassBox();
  }

  Future<void> deletePass(int index) async {
    Box<PassWidgetDataModel> passBox =
        Hive.box<PassWidgetDataModel>(HiveBoxes.pass);
    passBox.deleteAt(index);
    readPassBox();
  }
}
