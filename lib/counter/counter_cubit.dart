import 'package:flutter_bloc/flutter_bloc.dart';
// ignore_for_file: avoid_print

/* CUBIT = Simplified version of BLoC */

class CounterCubit extends Cubit<int> {
  CounterCubit(super.initialState);

// increment method
  void increment() => emit(state + 1); // whatever the current state is = + 1

// decrement method (whatever the current state is = - 1)
  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  // on state change -> do something

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}
