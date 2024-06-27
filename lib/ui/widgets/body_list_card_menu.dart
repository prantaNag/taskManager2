import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(taskModel.title ?? ' '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ' '),
            Text(
              'Date: ${taskModel.createdDate}',
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  backgroundColor: Colors.pinkAccent,
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
