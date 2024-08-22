import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/addTaskScreen.dart';
import 'package:todo_app/routing/app_router.dart';
import 'package:todo_app/task_notifier.dart';


@RoutePage() // this annotation
class DisplayallTask extends StatelessWidget {
  const DisplayallTask({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO APP"),
      ),
      body: Consumer<TaskNotifier>(
        builder:
            (BuildContext context, TaskNotifier notifier, Widget? child) {
          List<String> taskList =
              notifier.getAllTaskAdded; //gets data from notifier class
          if(taskList.isNotEmpty){
            return ListView.builder(
                itemCount: taskList.length,
                // how many times this listview should get call, how many items should be displayed
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // contentPadding: EdgeInsets.all(8),
                    title: Text(taskList.elementAt(index)),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddTaskScreen(
                              //           isModified: true,
                              //           oldTask:
                              //           taskList.elementAt(index),
                              //         ))); //updateTaskScreen
                              //below code is replacement of above code using app_router plugin
                              context.router.navigate(AddTaskScreenRoute(
                                  isModified: true,
                                  oldTask: taskList.elementAt(index)));
                            },
                            icon: Icon(Icons.edit_note_outlined)),
                        //editIcon
                        IconButton(
                            onPressed: () {
                              Provider.of<TaskNotifier>(context,
                                  listen: false)
                                  .removeTask(taskList.elementAt(index));
                            },
                            icon: Icon(Icons.delete_outline_outlined))
                        //deleteIcon
                      ],
                    ),
                  );
                });
          }else{
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("Add Some Task",style : TextStyle(fontSize: 30))),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.navigate(AddTaskScreenRoute());
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => AddTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
