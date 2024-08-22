// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddTaskScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddTaskRouteArgs>(
          orElse: () => const AddTaskRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddTaskScreen(
          isModified: args.isModified,
          oldTask: args.oldTask,
        ),
      );
    },
    DisplayallTaskRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DisplayallTask(),
      );
    },
  };
}

/// generated route for
/// [AddTaskScreen]
class AddTaskScreenRoute extends PageRouteInfo<AddTaskRouteArgs> {
  AddTaskScreenRoute({
    bool isModified = false,
    String oldTask = "",
    List<PageRouteInfo>? children,
  }) : super(
          AddTaskScreenRoute.name,
          args: AddTaskRouteArgs(
            isModified: isModified,
            oldTask: oldTask,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTaskScreenRoute';

  static const PageInfo<AddTaskRouteArgs> page =
      PageInfo<AddTaskRouteArgs>(name);
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({
    this.isModified = false,
    this.oldTask = "",
  });

  final bool isModified;

  final String oldTask;

  @override
  String toString() {
    return 'AddTaskRouteArgs{isModified: $isModified, oldTask: $oldTask}';
  }
}

/// generated route for
/// [DisplayallTask]
class DisplayallTaskRoute extends PageRouteInfo<void> {
  const DisplayallTaskRoute({List<PageRouteInfo>? children})
      : super(
          DisplayallTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'DisplayallTaskRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
