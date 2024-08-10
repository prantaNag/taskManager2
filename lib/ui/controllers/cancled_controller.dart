import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/new_task_wrapper_model.dart';

import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';

import 'package:taskmanager/data/utilities/urls.dart';

class CanceledTaskController extends GetxController {
  bool _getCanceledTaskInProcess = false;
  List<TaskModel> _canceledTaskList = [];
  String _errorMessege = '';

  bool get getCanceledTaskInProcess => _getCanceledTaskInProcess;
  List<TaskModel> get canceledTaskList => _canceledTaskList;
  String get errorMessege => _errorMessege;

  Future<bool> getCanceledTask() async {
    bool isSuccess = false;
    _getCanceledTaskInProcess = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.canceledTask);

    if (response.isSuccess) {
      NewTaskWrapperModel taskListWrapperModel =
          NewTaskWrapperModel.fromJson(response.responseData);
      _canceledTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessege =
          response.errorMessage ?? 'Failed to get Canceled Task list';
    }
    _getCanceledTaskInProcess = false;
    update();

    return isSuccess;
  }
}
