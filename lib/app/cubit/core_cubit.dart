import 'package:bloc/bloc.dart';
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
}
