import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/new_task_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/prograss_indicator.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedInPrograss = false;
  List<TaskModel> newTaskList = [];
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
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
            child: Visibility(
              visible: _getCompletedInPrograss == false,
              replacement: const CenteredPrograssIndicator(),
              child: ListView.builder(
                itemCount: newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: newTaskList[index],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    _getCompletedInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if (response.inSuccess) {
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
  }
}
