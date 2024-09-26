import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home_page/actions.dart';
import '../home_page/custom_edit_text.dart';

class CustomDialogView extends StatelessWidget {
  const CustomDialogView({
    super.key,
    required this.controller,
    required this.onAcceptPressed,
    required this.onCancelPressed, this.title = '',
  });

  final Function() onAcceptPressed;
  final Function() onCancelPressed;
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    print('controller text --3------------  ${controller.text} ----  ${controller.toString()}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomEditText(controller: controller, title: title,),
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


class CustomDeleteDialogView extends StatelessWidget {
  const CustomDeleteDialogView({
    super.key,
    required this.onAcceptPressed,
    required this.onCancelPressed,
  });

  final Function() onAcceptPressed;
  final Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Lottie.asset('assets/error_red.json', width: 50, height: 50),
            SizedBox(width: 10,),
            Text('DELETE HABIT?'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: DeleteActions(
            onAcceptPressed: onAcceptPressed,
            onCancelPressed: onCancelPressed,
          ),
        ),
      ],
    );
  }
}



