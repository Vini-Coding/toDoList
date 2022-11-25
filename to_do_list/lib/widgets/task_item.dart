import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task, required this.onComplete})
      : super(key: key);
  final Task task;
  final Function(Task) onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('mm/dd/yyyy - HH:mm').format(task.dateTime),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                task.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
        ),
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        secondaryActions: [
          IconSlideAction(
            icon: Icons.done_outlined,
            color: Colors.green,
            caption: 'Done',
            onTap: () {
              onComplete(task);
            },
          ),
        ],
      ),
    );
  }
}
