import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:todo_app_udm/LoggerUtils.dart';
import 'package:todo_app_udm/Models/TaskModel.dart';
import 'package:todo_app_udm/db_helper.dart';

class TaskNotifier extends ChangeNotifier {
  // creates this once completed with crud operations
  final db = Db_helper.dbinstance;

  //
  List<TaskModel> _task = [];

  int _taskCounter = 0;

  // Define log tag
  static const String _TAG = "TaskNotifier";

  TaskNotifier() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    //   initDb function will be responsible for, creating DB if app is install for first time
    //   else next time onwards it will only initialize DB object
    bool isDbCreated = await db.createDbLocalStorage();
    //   now my Db is ready and open for transactions
    if (isDbCreated) {
      List<TaskModel> temptasklist = await db.getTaskList();
      if(temptasklist.isNotEmpty){
        for(var currentItem in temptasklist){
          _task.add(currentItem);
          _taskCounter++; // if 5 task, the counter value will be 5, next if we want to insert/add task
        //   the taskCounter should be 6 in addTask()
        }
      }
    }
    notifyListeners();
  }

  List<TaskModel> get task => _task;

  int get pendingTask {
    return _taskCounter;
  }

  // getter function to get all tasks list
  // List<TaskModel> get taskList {
  //   return _task;
  // }

  Future<void> addTask(TaskModel task) async {
    _taskCounter++;
    try {
      TaskModel tm = TaskModel(
          taskid: _taskCounter,
          task: task.task,
          taskDetail: task.taskDetail,
          dateTime: task.dateTime);
      _task.add(tm);
      await db.insertTask(tm);
    } catch (err) {
      print(err);
    }
    LoggerUtils.logInfo("taskmodel : ${task}");
    notifyListeners();
  }

  Future<void> removeTask(TaskModel task) async{
    try {
      int taskId = _task.indexOf(task);
      LoggerUtils.logInfo("$_TAG: Task removed - ${_task[taskId].task}");
       _task.removeAt(taskId);
      await db.deleteTask(task.taskid); //need to increment by one becoz here
      // int taskId = _task.indexOf(task); at line u got index, and Id is starting from 1
      _taskCounter--;
      notifyListeners();
    } catch (err) {
      LoggerUtils.logError(err.toString());
    }
  }

  Future<void> editTask(TaskModel oldtask, TaskModel newTask) async {
    //at update we don't have assigned any id to newTask so it's null
    // we need to assign oldtask's id to newTask so that while updating record everything should work smoothly
    try {
      int index = _task.indexOf(oldtask);
      if (index != -1) {
        // int? taskId = oldtask.taskid!;
        _task[index] = newTask;
        // assigning same oldtask taskId to newTask
        newTask.taskid = oldtask.taskid;
        // await updateTask method in db_helper.dart
        await db.updateTask(newTask);
        notifyListeners();
        LoggerUtils.logInfo("${_TAG}: ${_task[index]} ");
        LoggerUtils.logInfo("${_TAG}: ${_task} ");
      }
      // }
    } catch (err) {
      LoggerUtils.logError("$_TAG : error at updating task $err");
    }
  }
}

//C:\Program Files\DB Browser for SQLite
