import 'package:bloc_cubit/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* 

COUNTER VIEW: This is responsible for just the UI

- use BlocBuilder

 */

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Counter using Cubit (BLoC)',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Center(
              child: Text(
                state.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            );
          },
        ),
        // BUTTONS
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // increment button
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),

            // decrement button
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ));
  }
}
