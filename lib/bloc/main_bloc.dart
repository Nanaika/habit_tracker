import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/data/habit_database.dart';

import '../domain/models/habit.dart';

class MainBloc extends Cubit<List<Habit>> {
  MainBloc(this.db) : super([]) {
    fetchAll();
  }

  final HabitDatabase db;

  void fetchAll() async {
    final habits = await db.fetchAllData();
    emit(habits);
  }

  void addHabit(String name) async {
    await db.addHabit(name);
    fetchAll();
  }

  void updateHabitCompletion(int id, bool isComplete) async {
    await db.updateHabitCompletion(id, isComplete);
    fetchAll();
  }

  void updateName(int id, String newName) async {
    await db.updateName(id, newName);
    fetchAll();
  }

  void delete(int id) async {
    await db.delete(id);
    fetchAll();
  }

  Future<DateTime?> getFirstLaunchDate() async {
    return await db.getFirstLaunchDate();
  }
}
