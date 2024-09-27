import 'package:habit_tracker/domain/models/app_settings.dart';
import 'package:isar/isar.dart';

import '../domain/models/habit.dart';

class HabitDatabase {
  late final Isar isar;

  HabitDatabase({required this.isar}) {
    saveFirstLaunchDate();
  }

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final firstSettings = AppSettings()..firstLaunch = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(firstSettings));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunch;
  }

  Future<void> addHabit(String name) async {
    final habit = Habit()..name = name;
    await isar.writeTxn(() => isar.habits.put(habit));
  }

  Future<List<Habit>> fetchAllData() async {
    return await isar.habits.where().findAll();
  }

  Future<void> updateHabitCompletion(int id, bool isComplete) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isComplete &&
            !habit.completedDays.contains(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day))) {
          final today = DateTime.now();
          final dateTime = DateTime(today.year, today.month, today.day);
          habit.completedDays.add(dateTime);
        } else {
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
        await isar.habits.put(habit);
      });
    }
  }

  Future<void> updateName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      habit.name = newName;
      await isar.writeTxn(() => isar.habits.put(habit));
    }
  }

  Future<void> delete(int id) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() => isar.habits.delete(id));
    }
  }
}

// bool _checkDateTime(List<DateTime> dates, DateTime date) {
//   for (var elem in dates) {
//     if (elem.year == date.year &&
//         elem.month == date.month &&
//         elem.day == date.day) {
//       return true;
//     }
//   }
//   return false;
// }
