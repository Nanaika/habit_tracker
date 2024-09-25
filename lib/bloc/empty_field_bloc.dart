import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyFieldBloc extends Cubit<bool> {
  EmptyFieldBloc() : super(false);

  bool isEmpty = false;

  void toggle(bool newValue) {
    isEmpty = newValue;
    emit(isEmpty);
  }

}