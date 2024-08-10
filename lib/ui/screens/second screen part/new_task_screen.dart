import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:taskmanager/ui/controllers/new_task_controlleer.dart';
import 'package:taskmanager/ui/controllers/task_by_count_controller.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/add_button_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
//import 'package:flutter/widgets.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

import 'package:taskmanager/ui/widgets/snackbar_message.dart';
import 'package:taskmanager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    initialcall();
  }

  void initialcall() {
    _getNewTasks();
    _getStatusByCount();
  }

  Future<void> _getNewTasks() async {
    bool newTaskResult = await Get.find<NewTaskController>().getNewTask();
    newTaskResult
        ? showSnackBarMessage(context, 'All new task loaded')
        : showSnackBarMessage(context, 'Failed to fetch new tasks. Try again');
  }

  Future<void> _getStatusByCount() async {
    bool taskByStatusCountResult =
        await Get.find<TaskByCountController>().getTaskStatusByCount();
    taskByStatusCountResult
        ? null
        : showSnackBarMessage(
            context, 'Failed to fetch all task status count. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  initialcall();
                },
                child:
                    GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProcess == false,
                    replacement: const CircularProgressIndicator(),
                    child: ListView.builder(
                        itemCount: newTaskController.newTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            taskModel: newTaskController.newTaskList[index],
                            onUpdateTask: initialcall,
                          );
                        }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return GetBuilder<TaskByCountController>(builder: (taskByCountController) {
      return Visibility(
        visible: taskByCountController.getTaskStatusByCountInProcess == false,
        replacement: const SizedBox(
          height: 100,
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: taskByCountController.taskCountByStutasList.map((e) {
              return TaskSummaryCard(
                  title: e.sId?.toUpperCase() ?? '', count: e.sum.toString());
            }).toList(),
          ),
        ),
      );
    });
  }

  void _onTapAddButton() {
    Get.to(() => const AddButtonScreen());
  }

  /* Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
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
  } */
}
