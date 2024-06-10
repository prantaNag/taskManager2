import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

class ProcessTaskScreen extends StatefulWidget {
  const ProcessTaskScreen({super.key});

  @override
  State<ProcessTaskScreen> createState() => _ProcessTaskScreenState();
}

class _ProcessTaskScreenState extends State<ProcessTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(),
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
