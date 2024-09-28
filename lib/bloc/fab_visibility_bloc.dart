import 'package:flutter_bloc/flutter_bloc.dart';

class FabVisibilityBloc extends Cubit<bool> {
  FabVisibilityBloc() : super(true);

  var isVisible = true;

  void toggle(bool isVis) {
    isVisible = isVis;
    emit(isVisible);
  }
}