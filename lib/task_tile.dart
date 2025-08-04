import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/task.dart';
import 'package:provider/task_provider.dart';

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) {
          ref.read(taskProvider.notifier).toggleTask(task.id);
        },
      ),
      title: Column(
        children: [
          Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed:
                () => ref.read(taskProvider.notifier).deleteTask(task.id),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => ref.read(taskProvider.notifier).deleteTask(task.id),
      ),
    );
  }
}
