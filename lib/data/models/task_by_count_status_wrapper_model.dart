import 'package:taskmanager/data/models/task_count_status_model.dart';

class TaskCountStatusWrapperModel {
  String? status;
  List<TaskCountStatusModel>? taskCountByStatusList;

  TaskCountStatusWrapperModel({this.status, this.taskCountByStatusList});

  TaskCountStatusWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountByStatusList = <TaskCountStatusModel>[];
      json['data'].forEach((v) {
        taskCountByStatusList!.add(TaskCountStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskCountByStatusList != null) {
      data['data'] = taskCountByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
