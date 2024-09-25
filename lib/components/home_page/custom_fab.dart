import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required this.controller, required this.onPressed,
  });

  final TextEditingController controller;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      onPressed: onPressed,
      child: Icon(
        CupertinoIcons.add,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}