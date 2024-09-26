import 'package:flutter/material.dart';

import '../../domain/models/habit.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key,
    required this.habit,
    required this.isCompleted,
    this.onChanged,
  });

  final Habit habit;
  final bool isCompleted;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isCompleted);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: ListTile(
          leading: Checkbox(
            value: isCompleted,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
          title: Text(habit.name),
        ),
      ),
    );
  }
}
