import 'package:bloc_cubit/counter/counter_cubit.dart';
import 'package:bloc_cubit/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* 

COUNTER PAGE is responsibile for providing CounterCubit to CounterView (UI)

- use BlocProvider 

*/

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider
    return BlocProvider(
      create: (context) => CounterCubit(0), // starting initial state from 0
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state == 10) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('10 reached!'),
              ),
            );
          }
        },
        child: const CounterView(), // UI
      ),
    );
  }
}


/* 
WITHOUT BlocListener :

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider
    return BlocProvider(
      create: (context) => CounterCubit(0), // starting initial state from 0
      child: const CounterView(), // UI
    );
  }
}

 */