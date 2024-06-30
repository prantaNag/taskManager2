import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/new_task_wrapper_model.dart';
import 'package:taskmanager/data/models/task_by_count_status_wrapper_model.dart';
import 'package:taskmanager/data/models/task_count_status_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
//import 'package:flutter/widgets.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/prograss_indicator.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';
import 'package:taskmanager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInPrograss = false;
  bool _getTaskCountByStatusInPrograss = false;
  List<TaskModel> newTaskList = [];
  List<TaskCountStatusModel> taskCountStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Column(
          children: [
            _buildSummerySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                  _getTaskCountByStatus();
                },
                child: Visibility(
                  visible: _getNewTaskInPrograss == false,
                  replacement: const CenteredPrograssIndicator(),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                        onUpdateTask: () {
                          _getNewTask();
                          _getTaskCountByStatus();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Visibility(
      visible: _getTaskCountByStatusInPrograss == false,
      replacement: const SizedBox(
        height: 100,
        child: CenteredPrograssIndicator(),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: taskCountStatusList.map((e) {
            return TaskSummaryCard(
              count: e.sum.toString(),
              title: (e.sId ?? 'Unknown').toUpperCase(),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _getNewTask() async {
    _getNewTaskInPrograss = true;
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
    _getNewTaskInPrograss = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.inSuccess) {
      TaskCountStatusWrapperModel taskCountStatusWrapperModel =
          TaskCountStatusWrapperModel.fromJson(response.responseData);
      taskCountStatusList =
          taskCountStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      showSnackBarMessage(
          context,
          response.errorMessage ??
              'Get task count by status failed. Try again!');
    }
    _getTaskCountByStatusInPrograss = false;
    if (mounted) {
      setState(() {});
    }
  }
}
