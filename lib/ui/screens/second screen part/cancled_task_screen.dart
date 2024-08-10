import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:taskmanager/data/models/task_model.dart';

import 'package:taskmanager/ui/controllers/cancled_controller.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';

import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
  List<TaskModel> canceledTaskList = [];
  @override
  void initState() {
    super.initState();
    _getCanceledTask();
  }

  Future<void> _getCanceledTask() async {
    bool result = await Get.find<CanceledTaskController>().getCanceledTask();
    result
        ? showSnackBarMessage(context, 'All canceled task loaded')
        : showSnackBarMessage(
            context, 'Failed to fetch canceled tasks. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCanceledTask();
          },
          child: GetBuilder<CanceledTaskController>(
              builder: (canceledTaskController) {
            return Visibility(
              visible: canceledTaskController.getCanceledTaskInProcess == false,
              replacement: const CircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: canceledTaskController.canceledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: canceledTaskController.canceledTaskList[index],
                      onUpdateTask: () {
                        _getCanceledTask();
                      },
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }

  /* Future<void> _getCompletedTask() async {
    _getCanceledTaskInProcess = true;
    if (mounted) setState(() {});

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.canceledTask);

    if (response.inSuccess) {
      NewTaskWrapperModel newTaskWrapperModel =
          NewTaskWrapperModel.fromJson(response.responseData);
      canceledTaskList = newTaskWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Failed to get Canceled Task list! Try again');
      }
    }
    _getCanceledTaskInProcess = false;
    if (mounted) setState(() {});
  } */
}
