# Cubit BLoC

## Bloc and Cubit Overview
### Basic Idea: 
To maintain a clean architecture in Flutter applications, it's essential to separate business logic from UI components. The BLoC (Business Logic Component) pattern facilitates this separation, and Cubit is a simplified version of BLoC for easier state managemen

## Cubit
#### Definition: 
Cubit is a lighter, more streamlined version of BLoC designed to manage state with less boilerplate code.

#### How to Use: 
To create a Cubit, you need to extend the Cubit class and specify the type of state it will manage.

```
// Cubit = Simplified version of BLoC

class CounterCubit extends Cubit<int> {
  // Constructor that initializes the state
  CounterCubit(super.initialState);

  // Method to increment the state 
  void increment() => emit(state + 1); // (whatever the current state is = + 1)

  // Method to decrement the state
  void decrement() => emit(state - 1); // (whatever the current state is = - 1)
}
```
In this example, CounterCubit manages an integer state. The emit method is used to update the state, which triggers the UI to rebuild with the new state.

## Counter Page
The Counter Page is responsible for providing the CounterCubit instance to the CounterView (UI). This is done using the BlocProvider.

To provide the Cubit to the UI, use the BlocProvider widget. It ensures that the Cubit instance is available to its child widgets and manages its lifecycle.

```
// COUNTER PAGE is responsibile for providing CounterCubit to CounterView (UI)
// - use BlocProvider 

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(0), // Provide CounterCubit with initial state 0
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state == 10) {
            // Show a dialog when the state reaches 10
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('10 reached!'),
              ),
            );
          }
        },
        child: const CounterView(), // Provide the UI to display and interact with CounterCubit
      ),
    );
  }
}
```

