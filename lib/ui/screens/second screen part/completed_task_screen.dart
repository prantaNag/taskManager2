import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:taskmanager/data/models/task_model.dart';

import 'package:taskmanager/ui/controllers/completed_task_controller.dart';

import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> newTaskList = [];
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  Future<void> _getCompletedTask() async {
    bool result = await Get.find<CompletedTaskController>().getCompletedTask();
    result
        ? showSnackBarMessage(context, 'All completed task loaded')
        : showSnackBarMessage(
            context, 'Failed to fetch completed tasks. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Expanded(
          child: RefreshIndicator(
              onRefresh: () async => _getCompletedTask(),
              child: GetBuilder<CompletedTaskController>(
                  builder: (completedTaskController) {
                return Visibility(
                  visible: completedTaskController.getCompletedTaskInProcess ==
                      false,
                  replacement: const CircularProgressIndicator(),
                  child: ListView.builder(
                      itemCount:
                          completedTaskController.completedTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          taskModel:
                              completedTaskController.completedTaskList[index],
                          onUpdateTask: () {
                            _getCompletedTask();
                          },
                        );
                      }),
                );
              })),
        ),
      ),
    );
  }

  /* Future<void> _getCompletedTask() async {
    _getCompletedInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if (response.isSuccess) {
      NewTaskWrapperModel newTaskWrapperModel =
          NewTaskWrapperModel.fromJson(response.responseData);
      newTaskList = newTaskWrapperModel.taskList ?? [];
    } else {
      showSnackBarMessage(
          context, response.errorMessage ?? 'Get new task not added.');
    }
    _getCompletedInPrograss = false;
    if (mounted) {
      setState(() {});
    }
  } */
}
