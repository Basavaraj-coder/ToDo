import 'package:flutter/material.dart';

class TaskNotifier extends ChangeNotifier {
  List<String> _tasklist = [];

  //int _tastSize = 0;

  List<String> get getAllTaskAdded =>
      _tasklist; //this is dart format of writing a getter using get, to get task

  void addTask(String task) {
    //setter for setting task
    _tasklist.add(task);

    notifyListeners(); //this notify the listeners, that there is change in data
  }

  void removeTask(String task) {
    int indexofTask = _tasklist.indexOf(task);
    _tasklist.removeAt(indexofTask);
    notifyListeners(); //this notify the listeners, that there is change in data
  }

  void updateTask(String oldTask, String newTask) {
    int indexofTask = _tasklist.indexOf(oldTask);
    _tasklist[indexofTask] = newTask;
    notifyListeners(); //this notify the listeners, that there is change in data
  }
}
