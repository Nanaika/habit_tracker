import 'package:flutter/material.dart';

import 'custom_dialog_view.dart';

void showCustomDialog({
  required BuildContext context,
  required TextEditingController controller,
  required Function() onAccept,
  required Function() onCancel,
  String title = '',
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: CustomDialogView(
            title: title,
            controller: controller,
            onAcceptPressed: onAccept,
            onCancelPressed: onCancel,
          ),
        );
      });
}


void showCustomDeleteDialog({
  required BuildContext context,
  required Function() onAccept,
  required Function() onCancel,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: CustomDeleteDialogView(
            onAcceptPressed: onAccept,
            onCancelPressed: onCancel,
          ),
        );
      });
}
