import 'package:flutter/material.dart';

import '../home_page/actions.dart';
import '../home_page/custom_edit_text.dart';

class CustomDialogView extends StatelessWidget {
  const CustomDialogView({
    super.key,
    required this.controller,
    required this.onAcceptPressed,
    required this.onCancelPressed,
  });

  final Function() onAcceptPressed;
  final Function() onCancelPressed;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomEditText(controller: controller,),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AddNewActions(
            onAcceptPressed: onAcceptPressed,
            onCancelPressed: onCancelPressed,
          ),
        ),
      ],
    );
  }
}