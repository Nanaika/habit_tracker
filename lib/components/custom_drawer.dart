import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../theme/theme/theme_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  children: [
                    Text(
                      'HABIT\nTRACKER',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(CupertinoIcons.brightness_solid),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'DARK MODE',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                        value: context.read<ThemeBloc>().isDark,
                        onChanged: (value) {
                          context.read<ThemeBloc>().toggleDarkMode();
                          final isDark = context.read<ThemeBloc>().isDark;
                          saveDarkMode(isDark);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void saveDarkMode(bool isDark) async {
  final sp = await SharedPreferences.getInstance();
  await sp.setBool(isDarkKey, isDark);
}
