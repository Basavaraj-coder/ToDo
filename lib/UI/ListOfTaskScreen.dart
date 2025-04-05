import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_udm/LoggerUtils.dart';
import 'package:todo_app_udm/Models/TaskModel.dart';
import 'package:todo_app_udm/Provider/TaskNotifier.dart';
import 'package:todo_app_udm/db_helper.dart';

class ListOfTaskScreen extends StatefulWidget {
  const ListOfTaskScreen({super.key});

  @override
  State<ListOfTaskScreen> createState() => _ListOfTaskScreenState();
}

class _ListOfTaskScreenState extends State<ListOfTaskScreen> {
  final List<TaskModel> tasks = []; // List to store tasks
  String? formattedDate;

  void _showAddTaskDialog([TaskModel? task]) {
    TextEditingController taskController = TextEditingController();
    TextEditingController taskDetailController = TextEditingController();

    if (task != null) {
      taskController.text = task.task;
      taskDetailController.text = task.taskDetail;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? "Add Task" : "Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: "Enter task Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Adds spacing
              TextField(
                controller: taskDetailController,
                maxLines: 4, // Increased height
                decoration: const InputDecoration(
                  hintText: "Enter task details",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String taskTitle = taskController.text.trim();
                String taskDetail = taskDetailController.text.trim();

                if (taskTitle.isNotEmpty && taskDetail.isNotEmpty) {
                  formattedDate = getDateTime();

                  if (task != null) {
                    Provider.of<TaskNotifier>(context, listen: false).editTask(
                        task,
                        TaskModel(
                            task: taskTitle,
                            taskDetail: taskDetail,
                            dateTime: formattedDate ?? "Date error"));
                  } else {
                    Provider.of<TaskNotifier>(context, listen: false).addTask(
                        TaskModel(
                            task: taskTitle,
                            taskDetail: taskDetail,
                            dateTime: formattedDate ?? "Date Error"));
                  }
                  Navigator.pop(context); // Close dialog
                }
              },
              child: Text(task == null ? "Add Task" : "Update Task"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Ensure copyDataBase() waits until the database is fully initialized.
    // for that purpose we have use .then() once copyDatabase() executes then only getTaskList() can execute
    // copyDataBase().then((_) {
    //   getTaskList(); // Ensure database is initialized before fetching tasks
    // }).catchError((e) {
    //   LoggerUtils.logError("Error initializing database: $e");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: Consumer<TaskNotifier>(
        builder:
            (BuildContext context, TaskNotifier tasknotifier, Widget? child) {
          List<TaskModel> taskList =
              tasknotifier.task; //gets data from notifier class
          if (taskList.isNotEmpty) {
            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  TaskModel task = taskList[index];
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.task,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            task.dateTime,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      subtitle: Text(task.taskDetail),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Provider.of<TaskNotifier>(context,
                                        listen: false)
                                    .removeTask(task);
                              },
                              icon: Icon(Icons.delete_outline_outlined)),
                          IconButton(
                              onPressed: () {
                                _showAddTaskDialog(task);
                              },
                              icon: Icon(Icons.edit))
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text("Add Some Task", style: TextStyle(fontSize: 30))),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  Steps now i want to open dialog box to input task
          _showAddTaskDialog();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text("Clicked FAB"))
          // );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String getDateTime() {
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    return formattedDate;
  }
}

Future<void> copyDataBase() async {
  const String _TAG = "copyDataBase()";
  final _dbhelper = Db_helper.dbinstance;
  bool isDBCopyFinished = await _dbhelper.createDbLocalStorage();
  LoggerUtils.logInfo("$_TAG is Db copy finished : $isDBCopyFinished");
}
void addTaskDB({required TaskModel task}) async {
  // TaskModel task = TaskModel(
  //     taskid: 10,
  //     task: "Bday celeb",
  //     taskDetail: "visit, Wet n joy",
  //     dateTime: "2025-03-22");
  const String _TAG = "addTask()";
  final _dbhelper = Db_helper.dbinstance;
  int rowId = await _dbhelper.insertTask(task);
  LoggerUtils.logInfo("$_TAG : $rowId got successfully");
}

void getTaskList() async {
  const String _TAG = "getTaskList()";
  final _dbhelper = Db_helper.dbinstance;
  List<TaskModel> taskList = await _dbhelper.getTaskList();
  LoggerUtils.logInfo("$_TAG tasklist got ${taskList}");
}




/*
* ListView.builder(
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Text("Details"),
                subtitle: Text("Meta data"),
                trailing: Column(
                  children: [
                    Icon(Icons.delete_outline_outlined),
                    Icon(Icons.edit)
                  ],
                ),
              ),
            );
          }
      ),
      * DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                  //
                  // setState(() {
                  //
                  //   Tasks.add(TaskModel(task: task,dateTime: formattedDate));
                  // });
* */
