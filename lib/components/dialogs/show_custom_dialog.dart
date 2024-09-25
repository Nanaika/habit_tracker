import 'package:flutter/material.dart';

import 'custom_dialog_view.dart';

void showCustomDialog({
  required BuildContext context,
  required TextEditingController controller,
  required Function() onAccept,
  required Function() onCancel,

}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: CustomDialogView(
            controller: controller,
            onAcceptPressed: onAccept,
            onCancelPressed: onCancel,

          ),
        );
      });
}