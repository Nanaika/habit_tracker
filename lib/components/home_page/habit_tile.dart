import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/models/habit.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key,
    required this.habit,
    required this.isCompleted,
    this.onChanged,
    this.onEdit,
    this.onDelete,
  });

  final Habit habit;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? onEdit;
  final void Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isCompleted);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12.0),
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.45,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: onEdit,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: CupertinoIcons.square_pencil,
                  // borderRadius: BorderRadius.circular(10),
                ),
                SlidableAction(
                  onPressed: onDelete,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  icon: CupertinoIcons.clear_circled,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              title: Text(habit.name),
            ),
          ),
        ),
      ),
    );
  }
}
