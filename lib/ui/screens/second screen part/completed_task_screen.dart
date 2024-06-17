import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return bodyListCardItem();
            },
          ),
        ),
      ),
    );
  }
}
