class TaskModel {
  int? taskid;
  String task;
  String taskDetail;
  String dateTime;

  TaskModel({
    this.taskid,
    required this.task,
    required this.taskDetail,
    required this.dateTime,
  });

  Map<String, dynamic> taskMapping() {
    return
      {
        "id": this.taskid,
        "task_title": this.task,
        "task_description": this.taskDetail,
        "task_date": this.dateTime
      };
  }

  // for logging
  @override
  String toString() {
    return 'TaskModel{task: $task, taskDetail: $taskDetail, dateTime: $dateTime}';
  }
}
