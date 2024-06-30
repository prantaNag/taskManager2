import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/widgets/prograss_indicator.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key, required this.taskModel, required this.onUpdateTask});

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteTaskInPrograss = false;
  bool _editInPrograss = false;
  String dropdownvalue = ' ';
  List<String> statusList = [
    'New',
    'Prograss',
    'Completed',
    'Canceled',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ' '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ' '),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  backgroundColor: Colors.pinkAccent,
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _deleteTaskInPrograss == false,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                        color: Colors.blue,
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                    Visibility(
                      visible: _editInPrograss == false,
                      replacement: const CenteredPrograssIndicator(),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.edit),
                        onSelected: (String selectedValue) {
                          dropdownvalue = selectedValue;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: ListTile(
                                title: Text(value),
                                trailing: dropdownvalue == value
                                    ? Icon(Icons.done)
                                    : null,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    /*  IconButton(
                      color: Colors.blue,
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ), */
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    _deleteTaskInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));
    if (response.inSuccess) {
      widget.onUpdateTask();
    } else {
      showSnackBarMessage(
          context,
          response.errorMessage ??
              'Get task count by status failed. Try again!');
    }
    _deleteTaskInPrograss = false;
    if (mounted) {
      setState(() {});
    }
  }
}
