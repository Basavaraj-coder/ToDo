import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/HomeScreen/displayAllTask.dart';
import 'package:todo_app/routing/app_router.dart';
import 'package:todo_app/task_notifier.dart';

//used short hand expression or arrow function or lambda expression
// because it was an single line expression, so use more
//efficient way of working with single line exp is arrow fun
void main() => runApp(

    // initialy/normaly it was MaterialApp(home: Displayalltask()) only this thing sufficient
    App());

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // but after using provider and consumer, i was getting error, so i need to add this ChangeNotifierProvider()
      create: (BuildContext context) => TaskNotifier(),
      // now this ChangeNotifierProvider we need to declare in root of the Widget
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "TODO Learning App",
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        builder: (BuildContext context, Widget? router){
          return router!;
        },
      ),
    );
  }
} //
