import 'package:flutter_bloc/flutter_bloc.dart';

class HabitListStateBloc extends Cubit<HabitListState> {
  HabitListStateBloc() : super(HabitsLoading()) {
    habitsState = HabitsLoading();
  }

  late HabitListState habitsState;

  void setState(HabitListState state) {
    habitsState = state;
    emit(habitsState);
  }

}




sealed class HabitListState {
}
class HabitsLoading extends HabitListState {}
class HabitsSuccess extends HabitListState {}
class HabitsEmpty extends HabitListState {}