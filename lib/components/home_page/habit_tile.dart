import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/theme/theme/theme_bloc.dart';
import 'package:habit_tracker/util/constants.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomSlidable(
            habit: habit,
            isCompleted: isCompleted,
            onChanged: onChanged,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }
}

class CustomSlidable extends StatelessWidget {
  const CustomSlidable(
      {super.key,
      this.onEdit,
      this.onDelete,
      required this.habit,
      required this.isCompleted,
      this.onChanged});

  final Habit habit;
  final bool isCompleted;
  final void Function(BuildContext)? onEdit;
  final void Function(BuildContext)? onDelete;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return Slidable(
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
                backgroundColor: errorColor,
                icon: CupertinoIcons.clear_circled,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
            ]),
        child: Container(
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              title: Text(
                habit.name,
                style: TextStyle(
                  color: setColor(context, isCompleted),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Slidable(
        startActionPane: ActionPane(
            extentRatio: 0.45,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: onDelete,
                backgroundColor: errorColor,
                icon: CupertinoIcons.clear_circled,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              SlidableAction(
                onPressed: onEdit,
                backgroundColor: Theme.of(context).colorScheme.primary,
                icon: CupertinoIcons.square_pencil,
                // borderRadius: BorderRadius.circular(10),
              ),
            ]),
        child: Container(
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              title: Text(
                habit.name,
                style: TextStyle(
                  color: setColor(context, isCompleted),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

Color setColor(BuildContext context, bool isCompleted) {
  if (context.read<ThemeBloc>().isDark && isCompleted) {
    return Colors.black;
  } else if (!context.read<ThemeBloc>().isDark && isCompleted) {
    return Colors.white;
  } else {
    return Theme.of(context).colorScheme.inversePrimary;
  }
}
