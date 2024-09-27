import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/theme/theme/theme.dart';

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc(this.isDark) : super(lightTheme) {
    if (isDark) {
      darkSystemUi();
      emit(darkTheme);
    } else {
      lightSystemUi();
      emit(lightTheme);
    }
  }

  bool isDark;

  void toggleDarkMode() {
    isDark = !isDark;
    if (isDark) {
      darkSystemUi();
      emit(darkTheme);
    } else {
      lightSystemUi();
      emit(lightTheme);
    }

  }
}

void lightSystemUi() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark),
  );

}
void darkSystemUi() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light),
  );
}
