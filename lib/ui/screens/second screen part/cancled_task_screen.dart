import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/new_task_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
// import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
  bool _getCanceledTaskInProcess = false;
  List<TaskModel> canceledTaskList = [];
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
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTask();
          },
          child: Visibility(
            visible: _getCanceledTaskInProcess == false,
            replacement: const CircularProgressIndicator(),
            child: Expanded(
              child: ListView.builder(
                itemCount: canceledTaskList.length,
                itemBuilder: (context, index) {
                  TaskItem(
                    taskModel: canceledTaskList[index],
                    onUpdateTask: () {
                      _getCompletedTask();
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

  Future<void> _getCompletedTask() async {
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
  }
}
