# Cubit BLoC

## Bloc and Cubit Overview
### Basic Idea: 
To maintain a clean architecture in Flutter applications, it's essential to separate business logic from UI components. The BLoC (Business Logic Component) pattern facilitates this separation, and Cubit is a simplified version of BLoC for easier state managemen

## Why Use Cubit Instead of BLoC?
- ### Context:
BLoC (Business Logic Component) is a pattern used for managing state in Flutter applications. It involves more boilerplate code and requires defining events and states, which can be complex for simple use cases.

- ### Introduction of Cubit:
Cubit was introduced as a simplified alternative to BLoC. It reduces boilerplate code and simplifies state management, making it more accessible for developers who need to manage state without the additional complexity of BLoC.

- ### Key Differences and Benefits:

1. #### Simplicity:

- Cubit is easier to use than BLoC for simple state management tasks. It eliminates the need for defining events, which makes the code less verbose and easier to maintain.

2. #### Reduced Boilerplate:

- Cubit requires less boilerplate code. You only need to extend Cubit, define the state type, and implement methods to update the state. This contrasts with BLoC, where you need to define events, states, and the mapping between them.

3. #### Focused Use Cases:

- Cubit is designed for straightforward state management scenarios. If your application involves complex state transitions and interactions, BLoC might still be appropriate. For simpler cases, Cubit offers a more streamlined approach.

4. #### Performance:

- Cubit can provide better performance in scenarios where you don’t need the full event-to-state mapping logic provided by BLoC. It’s lighter and faster for managing simple state changes.

### When to Use Which:

### Cubit: 
Best for simpler state management needs with minimal state transitions and events. Ideal for applications or components where the state logic is straightforward.

### BLoC: 
Better suited for more complex state management scenarios involving intricate state transitions, multiple events, and a more structured approach.

### Summary: 
Cubit was introduced to simplify state management for simpler use cases, reducing the amount of boilerplate code required compared to BLoC. While BLoC remains valuable for complex state management, Cubit provides a more straightforward alternative for less complex scenarios.

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

### Key Points:

- Cubit Provisioning: BlocProvider makes the CounterCubit instance available to its child widgets, including CounterView and BlocListener.
- State Management: CounterPage initializes the CounterCubit with an initial state and manages its lifecycle.
- Side Effects Handling: BlocListener listens for specific state changes and handles side effects, such as displaying dialogs.
- UI Separation: By using BlocProvider and BlocListener, CounterPage separates the state management and business logic from the UI presentation handled by CounterView.

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

## Counter View
The CounterView focuses solely on the user interface, displaying the current counter value and providing buttons to increment or decrement that value.

### How It Works:

- ### BlocBuilder: 
This widget listens for state changes in the CounterCubit and rebuilds the UI accordingly. It takes two parameters:

- ### Builder Function: 
This function receives the current CounterCubit state and is responsible for building the widget tree. In this case, it displays the counter value as text.
State: The current value of the counter, which is an integer in this example.

### Key Points:

- The CounterView does not manage state itself; instead, it relies on CounterCubit for state management.
- It uses BlocBuilder to react to state changes and update the UI without directly managing the state.
- By separating the UI from business logic, CounterView maintains a clear focus on presentation, while CounterCubit handles the underlying logic.

```
// COUNTER VIEW: Responsible for the UI
// - Uses BlocBuilder to rebuild the UI based on the state

class CounterView extends StatelessWidget {
  const CounterView({super.key});

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
              state.toString(), // Display the current counter value
              style: const TextStyle(fontSize: 30),
            ),
          );
        },
      ),
      // Floating action buttons for incrementing and decrementing the counter
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Increment button
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),

          // Decrement button
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
```

