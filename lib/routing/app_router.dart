import 'package:auto_route/auto_route.dart';

import '../HomeScreen/displayAllTask.dart';
import '../addTaskScreen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  List<AutoRoute> get routes => [
        AutoRoute(page: DisplayallTaskRoute.page, path: "/HomeScreen", initial: true),
         AutoRoute(page: AddTaskScreenRoute.page, path: "/AddTaskScreen", )
      ];
}
