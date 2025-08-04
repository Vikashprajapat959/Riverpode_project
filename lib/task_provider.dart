import 'package:provider/task.dart';
import 'package:riverpod/riverpod.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    state = [...state, newTask];
  }

  void toggleTask(String id) {
    state =
        state.map((task) {
          if (task.id == id) {
            return task.copyWith(isDone: !task.isDone);
          }
          return task;
        }).toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
