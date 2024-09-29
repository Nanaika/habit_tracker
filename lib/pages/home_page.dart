import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/empty_field_bloc.dart';
import 'package:habit_tracker/bloc/main_bloc.dart';
import 'package:habit_tracker/components/heat_map.dart';
import 'package:habit_tracker/components/home_page/empty_habits_view.dart';
import 'package:habit_tracker/util/is_habit_complete_today.dart';

import '../bloc/fab_visibility_bloc.dart';
import '../components/custom_drawer.dart';
import '../components/dialogs/show_custom_dialog.dart';
import '../components/home_page/custom_fab.dart';
import '../components/home_page/habit_tile.dart';
import '../domain/models/habit.dart';
import '../util/prepare_data_set.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();

  var isFabVisible = true;

  final scrollController = ScrollController();

  late final AnimationController animController;
  late final Animation<Offset> slideTransition;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    slideTransition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 10),
    ).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void showFabIfNoScrollItems() {
    if (scrollController.hasClients) {
      if (scrollController.position.maxScrollExtent <=
          scrollController.position.minScrollExtent) {
        context.read<FabVisibilityBloc>().toggle(true);
        animController.reverse();
      }
    }
  }

  Widget buildPortrait() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Theme.of(context).colorScheme.surface.withOpacity(0.02),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: SlideTransition(
        position: slideTransition,
        child: CustomFAB(
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
      ),
      body: SafeArea(
        child: BlocBuilder<MainBloc, List<Habit>>(
          builder: (BuildContext context, habits) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showFabIfNoScrollItems();
            });
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: setHeatMap(context, habits)),
                Expanded(
                  child: habits.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          // physics: const AlwaysScrollableScrollPhysics(
                          //   parent: BouncingScrollPhysics(),
                          // ),
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
                                        context
                                            .read<EmptyFieldBloc>()
                                            .toggle(true);
                                        return;
                                      }
                                      editHabitName(
                                          controller.text, habit.id, context);
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
                              onChanged: (value) =>
                                  checkHabitOnOff(value, habit, context),
                            );
                          })
                      : EmptyHabitsView(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

//start landscape
  Widget buildLandscape() {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const CustomDrawer(),
      floatingActionButton: SlideTransition(
        position: slideTransition,
        child: CustomFAB(
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
      ),
      body: BlocBuilder<MainBloc, List<Habit>>(
        builder: (BuildContext context, habits) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showFabIfNoScrollItems();
          });
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SafeArea(
                right: false,
                top: false,
                bottom: false,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: setHeatMap(context, habits)),
              ),
              Expanded(
                child: habits.isNotEmpty
                    ? SafeArea(
                        top: false,
                        child: ListView.builder(
                            controller: scrollController,
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
                                          context
                                              .read<EmptyFieldBloc>()
                                              .toggle(true);
                                          return;
                                        }
                                        editHabitName(
                                            controller.text, habit.id, context);
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
                                onChanged: (value) =>
                                    checkHabitOnOff(value, habit, context),
                              );
                            }),
                      )
                    : EmptyHabitsView(),
              ),
            ],
          );
        },
      ),
    );
  }

//end landscape
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          context.read<FabVisibilityBloc>().state &&
          scrollController.offset ==
              scrollController.position.maxScrollExtent) {
        context.read<FabVisibilityBloc>().toggle(false);
        animController.forward();
      } else if (!scrollController.position.atEdge &&
          !context.read<FabVisibilityBloc>().state) {
        context.read<FabVisibilityBloc>().toggle(true);
        animController.reverse();
      }
    });

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return orientation == Orientation.landscape
            ? buildLandscape()
            : buildPortrait();
      },
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

Widget setHeatMap(BuildContext context, List<Habit> habits) {
  final future = context.read<MainBloc>().getFirstLaunchDate();
  return FutureBuilder(
    future: future,
    builder: (ctx, snap) {
      if (snap.data != null) {
        return CustomHeatMap(
            startDate: snap.data!, dataset: prepDataSet(habits));
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        );
      }
    },
    initialData: DateTime.timestamp(),
  );
}
