import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/task.dart';

const tasksListKey = 'tasks_list';

class TasksListRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Task>> getTaskList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(tasksListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Task.fromJson(e)).toList();
  }

  void saveTasksList(List<Task> tasks) {
    final String jsonString = json.encode(tasks);
    sharedPreferences.setString(tasksListKey, jsonString);
  }
}
