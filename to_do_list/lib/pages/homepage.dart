import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/repositories/tasks_list_repository.dart';
import 'package:to_do_list/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController taskController = TextEditingController();
  final TasksListRepository tasksListRepository = TasksListRepository();
  List<Task> tasks = [];
  Task? deletedTask;
  int? deletedTaskIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Add a Task",
                          hintText: "Ex. Study Flutter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          String text = taskController.text;
                          Task newTask =
                              Task(title: text, dateTime: DateTime.now());
                          tasks.add(newTask);
                        });
                        tasksListRepository.saveTaksList(tasks);
                        taskController.clear();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Task task in tasks)
                        TaskItem(
                          task: task,
                          onComplete: onComplete,
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('There is ${tasks.length} tasks left'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeleteTasksConfirmationDialog,
                      child: const Text('Clean all'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onComplete(Task task) {
    deletedTask = task;
    deletedTaskIndex = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 222, 242, 243),
        duration: const Duration(seconds: 5),
        content: Text(
          'Task ${task.title} completed succesfully.',
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        action: SnackBarAction(
          label: 'Undone',
          textColor: const Color.fromARGB(255, 0, 52, 59),
          onPressed: () {
            setState(() {
              tasks.insert(deletedTaskIndex!, deletedTask!);
            });
          },
        ),
      ),
    );
  }

  void showDeleteTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clean all Tasks?'),
        content: const Text(
            'Are you sure that you want to clean all the Tasks of your To-Do List?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: const Color(0xff00d7f3)),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                tasks.clear();
              });
            },
            style: TextButton.styleFrom(primary: Colors.red),
            child: const Text('Clean All'),
          ),
        ],
      ),
    );
  }
}
