import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/task_provider.dart';
import 'package:provider/task_tile.dart'; // ✅ Required for Riverpod

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('TaskBuddy', style: TextStyle(color: Colors.deepPurple)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter task title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty) {
                      ref.read(taskProvider.notifier).addTask(text);
                      controller.clear();
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                tasks.isEmpty
                    ? Center(child: Text("No tasks added."))
                    : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskTile(task: tasks[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
