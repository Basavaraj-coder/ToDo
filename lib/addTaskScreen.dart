import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/task_notifier.dart';

@RoutePage()
class AddTaskScreen extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey();
  final TextEditingController _controller = TextEditingController(); //you can assign default value here
  late bool isModified;
  late String oldTask;

  AddTaskScreen({this.isModified = false, this.oldTask = ""}); // named parameters

  @override
  Widget build(BuildContext context) {
    if (isModified) {
      _controller.text = oldTask;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task Screen"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Add Task",
                    hintStyle: TextStyle(color: Colors.black26),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.green),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.yellow),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (String? input) {
                    if (input != null && input.isNotEmpty) {
                      return null; // return null means no issues
                    } else {
                      return "Enter Task Description";
                    }
                  },
                ),
                SizedBox(height: 16.0),
                FilledButton(
                    onPressed: () {
                      if (_formState.currentState != null &&
                          _formState.currentState!.validate()) {
                        //what does form do is
                        //we have to call provider
                        if (isModified) {
                          Provider.of<TaskNotifier>(context, listen: false)
                              .updateTask(oldTask, _controller.text);
                        } else {
                          Provider.of<TaskNotifier>(context, listen: false)
                              .addTask(_controller
                              .text); //call notifier's addtask to put data to
                        }
                        Navigator.pop(context); //pops addtask screen and navigates back to DisplayAllTaskScreen
                      }
                    },
                    child: const Text("Add Task"))
              ],
            ),
          )
      ),
    );
  }
}
