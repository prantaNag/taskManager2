import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/new_task_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
//import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class ProcessTaskScreen extends StatefulWidget {
  const ProcessTaskScreen({super.key});

  @override
  State<ProcessTaskScreen> createState() => _ProcessTaskScreenState();
}

class _ProcessTaskScreenState extends State<ProcessTaskScreen> {
  bool _getProgressedTaskInProcess = false;
  List<TaskModel> progressedTaskList = [];
  @override
  void initState() {
    super.initState();
    _getProgressedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          _getProgressedTask();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
          child: Visibility(
            visible: _getProgressedTaskInProcess == false,
            replacement: const CircularProgressIndicator(),
            child: Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: progressedTaskList[index],
                    onUpdateTask: () {
                      _getProgressedTask();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressedTask() async {
    _getProgressedTaskInProcess = true;
    if (mounted) setState(() {});

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressedTask);

    if (response.inSuccess) {
      NewTaskWrapperModel newTaskWrapperModel =
          NewTaskWrapperModel.fromJson(response.responseData);
      progressedTaskList = newTaskWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Failed to get Progressed Task list! Try again');
      }
    }
    _getProgressedTaskInProcess = false;
    if (mounted) setState(() {});
  }
}
