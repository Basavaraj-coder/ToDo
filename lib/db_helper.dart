import 'dart:async';
import 'dart:core';
import 'dart:io'; // For `Directory`
import 'package:path/path.dart'; // For `join` and `dirname`
import 'package:flutter/services.dart'; //for ByteData and rootBundle
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_udm/Base/app_constants.dart';
import 'package:todo_app_udm/LoggerUtils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app_udm/Models/TaskModel.dart';

//Provides Flutter FFI (Foreign Function Interface) for sqflite,
// allowing database access on Windows, MacOS, and Linux (not just mobile).

class Db_helper {
  // logger tag
  static const String _TAG = "Db_helper";

  // static instance
  /*
ensures a Single Instance
The Db_helper._init(); method initializes the singleton only once.
Prevents multiple instances of Db_helper.
  * */
  static final Db_helper _instance = Db_helper._init();

  static Db_helper get dbinstance => _instance;

  // to achieve singleton we need private constructor
  Db_helper._init();

  //created late database instance
  late Database _dbinstance;

  //step 1 is db creation
  //here why future becoz in case of big data from DB if we need to copy from Db,
  //it will take some time that's why we used future, it will return data in future so that will take some time
  Future<bool> createDbLocalStorage() async {
    try {
      // get database path automatically from assets
      var databasePath = await getDatabasesPath();

      // Joins the database directory path with the database name from AppConstants.
      /*
      💡 Example Path:
📌 Android: /data/data/com.example.app/databases/todo_db.sqlite
📌 iOS: /Library/Application Support/todo_db.sqlite
      * */
      var path = join(databasePath, AppConstants.DatabaseName);

      // Checks if the database already exists in local storage.
      // Returns true if it exists, false otherwise.
      bool isDbExists = await databaseExists(path);

      // If the database does not exist, it copies it from assets.
      if (!isDbExists) {
        //copying the Db here, Creates the directory for storing the database if it doesn’t already exist
        await Directory(dirname(path)).create(recursive: true);

        // Loads the database file from the assets folder.
        ByteData data = await rootBundle
            .load(join("assets/database", AppConstants.DatabaseName));

        // Converts the loaded database into a list of bytes.
        List<int> dbSize =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        // Writes the copied database to the local storage path.
        await File(path).writeAsBytes(dbSize, flush: true);
      }

      // Opens the SQLite database at the specified path.
      // Stores the database instance in _dbinstance.
      // path here is local storage path before this line we need to import sqflite_ffi.dart
      _dbinstance = await openDatabase(path);

      // Returns true if the database is created successfully.
      return Future.value(true);
    } catch (exception) {
      // If any error occurs, it returns a Future error message.
      return Future.error("Db copy failed : $exception");
    }
    //return false;

    /*
    * Full Execution Flow
1️⃣ Get the database storage path.
2️⃣ Check if the database already exists.
3️⃣ If not exists, copy the prebuilt database from assets.
4️⃣ Open the database and store the instance.
5️⃣ Return true if successful, otherwise return an error.

*/
  }

// step 2 getting list of task
  Future<List<TaskModel>> getTaskList() async {
    try {
      List<TaskModel> taskList = List.empty(growable: true);
      String query = "select * from ${AppConstants.TableName}";
      var resultSet = await _dbinstance.rawQuery(query);
      LoggerUtils.logInfo("$_TAG in gettasklist() : ${resultSet.runtimeType}");
      for (var currentRow in resultSet) {
        int taskId = int.parse(currentRow["id"].toString());
        String task_title = currentRow["task_title"].toString();
        String task_description = currentRow["task_description"].toString();
        String task_date = currentRow["task_date"].toString();
        taskList.add(TaskModel(
            taskid: taskId,
            task: task_title,
            taskDetail: task_description,
            dateTime: task_date));
      }
      return Future.value(taskList);
    } catch (exception) {
      return Future.error("error in getting taskList : $exception");
    }
  }

// step 3 inserting task
  Future<int> insertTask(TaskModel task) async {
    try {
      int rowId = await _dbinstance.insert(
          AppConstants.TableName, task.taskMapping(),
          // if at all any duplicate data it will replace by adding conflictAlgorithm
          conflictAlgorithm: ConflictAlgorithm.replace);
      return Future.value(rowId);
    } catch (exception) {
      return Future.error("Error in inserting data $exception");
    }
  }

// setp 4 updating task
  Future<void> updateTask(TaskModel task) async {
    try {
      await _dbinstance.update(AppConstants.TableName, task.taskMapping(),
          where: "id = ?", whereArgs: [task.taskid] // Safe binding
          );
    } catch (exception) {
      LoggerUtils.logInfo("$_TAG exception in updating task $exception");
    }
  }

// setp 5 deleting task
  Future<void> deleteTask(int? taskIndex) async {
    try {
      if (taskIndex != null) {
        await _dbinstance.delete(AppConstants.TableName,
            where: "id = ?",
            //this ? placeholder replaces with taskIndex from whereargs
            whereArgs: [taskIndex]);
      }
    } catch (exception) {
      LoggerUtils.logInfo("$_TAG exception in Deleting task $exception");
    }
  }
}
