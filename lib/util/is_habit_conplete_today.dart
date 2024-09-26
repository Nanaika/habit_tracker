bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (elem) =>
        elem.year == today.year &&
        elem.month == today.month &&
        elem.day == today.day,
  );
}
