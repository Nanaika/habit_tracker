import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/empty_field_bloc.dart';
import 'package:habit_tracker/bloc/main_bloc.dart';
import 'package:habit_tracker/util/is_habit_conplete_today.dart';

import '../components/custom_drawer.dart';
import '../components/dialogs/show_custom_dialog.dart';
import '../components/home_page/custom_fab.dart';
import '../components/home_page/habit_tile.dart';
import '../domain/models/habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFAB(
        onPressed: () {
          controller.clear();
          showCustomDialog(
            title: 'NEW HABIT',
            context: context,
            controller: controller,
            onAccept: () {
              if (controller.text.isEmpty) {
                context.read<EmptyFieldBloc>().toggle(true);
                return;
              }
              context.read<MainBloc>().addHabit(controller.text);
              Navigator.of(context).pop();
              controller.clear();
            },
            onCancel: () {
              Navigator.of(context).pop();
              controller.clear();
            },
          );
        },
      ),
      body: BlocBuilder<MainBloc, List<Habit>>(
        builder: (BuildContext context, habits) {
          return ListView.builder(
              itemCount: habits.length,
              itemBuilder: (ctx, index) {
                final habit = habits[index];
                final isCompletedToday =
                    isHabitCompletedToday(habit.completedDays);
                return HabitTile(
                  onEdit: (ctx) {
                    controller.text = habit.name;
                    showCustomDialog(
                        context: context,
                        controller: controller,
                        title: 'EDIT HABIT',
                        onCancel: () {
                          Navigator.of(context).pop();
                          controller.clear();
                        },
                        onAccept: () {
                          if (controller.text.isEmpty) {
                            context.read<EmptyFieldBloc>().toggle(true);
                            return;
                          }
                          editHabitName(controller.text, habit.id, context);
                          controller.clear();
                          Navigator.of(context).pop();
                        });
                  },
                  onDelete: (ctx) {
                    showCustomDeleteDialog(
                        context: context,
                        onAccept: () {
                          deleteHabit(habit.id, context);
                          controller.clear();
                          Navigator.of(context).pop();
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                          controller.clear();
                        });
                  },
                  habit: habit,
                  isCompleted: isCompletedToday,
                  onChanged: (value) => checkHabitOnOff(value, habit, context),
                );
              });
        },
      ),
    );
  }
}

void deleteHabit(int id, BuildContext context) {
  context.read<MainBloc>().delete(id);
}

void editHabitName(String newName, int id, BuildContext context) {
  context.read<MainBloc>().updateName(id, newName);
}

void checkHabitOnOff(bool? value, Habit habit, BuildContext context) {
  if (value != null) {
    context.read<MainBloc>().updateHabitCompletion(habit.id, value);
  }
}
