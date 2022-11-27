import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/task.dart';

class TasksListRepository {
  TasksListRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  void saveTaksList(List<Task> tasks) {
    final String jsonString = json.encode(tasks);
    sharedPreferences.setString('tasks_list', jsonString);
  }
}
