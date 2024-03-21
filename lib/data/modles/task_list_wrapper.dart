
import 'package:tms/data/modles/task_item.dart';

class TaskListWrapper {
  String? status;
  List<TaskItem>? taskList;

  TaskListWrapper({this.status, this.taskList});

  TaskListWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskItem>[];
      json['data'].forEach((v) {
        taskList!.add(TaskItem.fromJson(v));
      });
    }
  }
}

