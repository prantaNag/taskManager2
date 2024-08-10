import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_by_count_status_wrapper_model.dart';
import 'package:taskmanager/data/models/task_count_status_model.dart';

import 'package:taskmanager/data/networkCaller/network_caller.dart';

import 'package:taskmanager/data/utilities/urls.dart';

class TaskByCountController extends GetxController {
  bool _getTaskStatusByCountInProcess = false;
  List<TaskCountStatusModel> _taskCountByStutasList = [];
  String _errorMessege = '';

  bool get getTaskStatusByCountInProcess => _getTaskStatusByCountInProcess;
  List<TaskCountStatusModel> get taskCountByStutasList =>
      _taskCountByStutasList;
  String get errorMessege => _errorMessege;

  Future<bool> getTaskStatusByCount() async {
    bool isSuccess = false;
    _getTaskStatusByCountInProcess = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskCountStatusWrapperModel taskStatusCountWrapperModelModel =
          TaskCountStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStutasList =
          taskStatusCountWrapperModelModel.taskCountByStatusList ?? [];
      isSuccess = true;
    } else {
      _errorMessege = response.errorMessage ?? 'Faild to get task count status';
    }
    _getTaskStatusByCountInProcess = false;
    update();

    return isSuccess;
  }
}
