import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/body_list_card_menu.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
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
