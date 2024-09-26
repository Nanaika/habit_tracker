import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/empty_field_bloc.dart';

class CustomEditText extends StatelessWidget {
  const CustomEditText({
    super.key,
    required this.controller, this.title = '',

  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    context.read<EmptyFieldBloc>().toggle(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(onChanged: (text) {
              if(text.isEmpty) {
                context.read<EmptyFieldBloc>().toggle(true);
              } else {
                context.read<EmptyFieldBloc>().toggle(false);
              }
            },
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'enter here ...',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<EmptyFieldBloc, bool>(
          builder: (BuildContext context, state) {
            if (state == true) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 4.0),
                child: Text(
                  'EMPTY FIELD',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
