import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/empty_field_bloc.dart';
import 'package:habit_tracker/bloc/main_bloc.dart';

import '../components/custom_drawer.dart';
import '../components/dialogs/show_custom_dialog.dart';
import '../components/home_page/custom_fab.dart';
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
        controller: controller,
        onPressed: () {
          showCustomDialog(
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
                return ListTile(
                  title: Text(habit.name),
                  subtitle: Text(habit.id.toString()),
                );
              });
        },
      ),
    );
  }
}
