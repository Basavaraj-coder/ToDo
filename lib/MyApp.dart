import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_udm/Resources/AppThemeData.dart';
import 'package:todo_app_udm/Provider/TaskNotifier.dart';
import 'package:todo_app_udm/Resources/app_colors.dart';
import 'package:todo_app_udm/UI/ListOfTaskScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.themeData, //external class created for ThemeData
        home: ListOfTaskScreen(),
      ),
    );
  }
}
