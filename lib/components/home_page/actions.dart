import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/util/constants.dart';

class AddNewActions extends StatelessWidget {
  const AddNewActions({
    super.key,
    required this.onAcceptPressed,
    required this.onCancelPressed,
  });

  final Function() onAcceptPressed;
  final Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              onAcceptPressed.call();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.inversePrimary),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            child: Text(
              'SAVE',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
          onPressed: () {
            onCancelPressed.call();
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          child: const Icon(CupertinoIcons.clear_circled),
        ),
      ],
    );
  }
}

class DeleteActions extends StatelessWidget {
  const DeleteActions({
    super.key,
    required this.onAcceptPressed,
    required this.onCancelPressed,
  });

  final Function() onAcceptPressed;
  final Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              onAcceptPressed.call();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                errorColor,
              ),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            child: Text(
              'DELETE',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
          onPressed: () {
            onCancelPressed.call();
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          child: const Icon(CupertinoIcons.clear_circled),
        ),
      ],
    );
  }
}
