import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
//import 'package:flutter/widgets.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Column(
          children: [
            _buildSummerySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return bodyListCardItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummerySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            title: 'New Task',
            count: '34',
          ),
          TaskSummaryCard(
            title: 'Completed',
            count: '34',
          ),
          TaskSummaryCard(
            title: 'Process',
            count: '34',
          ),
          TaskSummaryCard(
            title: 'Cancelled',
            count: '34',
          ),
        ],
      ),
    );
  }
}
