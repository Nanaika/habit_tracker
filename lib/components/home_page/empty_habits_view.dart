import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyHabitsView extends StatelessWidget {
  const EmptyHabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/not_found.json', width: 75, height: 75, repeat: false),
          const Text('No habits yet. Start your first one now!'),
        ],
      ),
    );
  }
}