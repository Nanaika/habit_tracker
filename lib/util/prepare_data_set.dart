import '../domain/models/habit.dart';

Map<DateTime, int> prepDataSet(List<Habit> habits) {
  Map<DateTime, int> dataSet = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      if (dataSet.containsKey(normalizedDate)) {
        dataSet[normalizedDate] = dataSet[normalizedDate]! + 1;
      } else {
        dataSet[normalizedDate] = 1;
      }
    }
  }
  return dataSet;
}