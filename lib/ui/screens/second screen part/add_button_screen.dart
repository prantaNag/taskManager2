import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:taskmanager/ui/controllers/add_new_task-controller.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class AddButtonScreen extends StatefulWidget {
  const AddButtonScreen({super.key});

  @override
  State<AddButtonScreen> createState() => _AddButtonScreenState();
}

class _AddButtonScreenState extends State<AddButtonScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Description';
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                    return Visibility(
                      visible:
                          addNewTaskController.addNewTaskInProgess == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addNewTask();
                            }
                          },
                          child: const Text('Add')),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    bool result = await Get.find<AddNewTaskController>()
        .addNewTask(_titleTEController.text.trim(), _titleTEController.text);
    result
        ? showSnackBarMessage(context, 'New Task Added Successfully')
        : showSnackBarMessage(context, 'Failed to add New Task. Try again');
  }

  /* Future<void> _addNewTask() async {
    _addNewTaskInPrograss = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "title": _titleTeController.text.trim(),
      "description": _descriptionTeController.text.trim(),
      "status": "New",
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, requestData);

    _addNewTaskInPrograss = false;
    if (mounted) {
      setState(() {});
    }

    if (response.inSuccess) {
      _clearTextFields();
      if (mounted) {
        showSnackBarMessage(context, "New Task Added");
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, "New Task Added Failed! Try Again", true);
        }
      }
    }
  } */
}
