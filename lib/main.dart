import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/empty_field_bloc.dart';
import 'package:habit_tracker/bloc/main_bloc.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:habit_tracker/theme/theme/theme_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/models/app_settings.dart';
import 'domain/models/habit.dart';

const isDarkKey = 'isDark';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final sp = await SharedPreferences.getInstance();

  final isDark = sp.getBool(isDarkKey) ?? false;

  final dir = await getApplicationDocumentsDirectory();
  final isar =
      Isar.openSync([HabitSchema, AppSettingsSchema], directory: dir.path);

  runApp(MyApp(
    isDark: isDark,
    isar: isar,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark, required this.isar});

  final bool isDark;
  final Isar isar;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ThemeBloc(isDark)),
        BlocProvider(create: (ctx) => MainBloc(HabitDatabase(isar: isar))),
        BlocProvider(create: (ctx) => EmptyFieldBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (BuildContext context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Habit tracker',
            theme: theme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
