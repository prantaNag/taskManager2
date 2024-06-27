import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/prograss_indicator.dart';
import 'package:taskmanager/ui/widgets/snackbar_message.dart';

class AddButtonScreen extends StatefulWidget {
  const AddButtonScreen({super.key});

  @override
  State<AddButtonScreen> createState() => _AddButtonScreenState();
}

class _AddButtonScreenState extends State<AddButtonScreen> {
  final TextEditingController _titleTeController = TextEditingController();
  final TextEditingController _descriptionTeController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInPrograss = false;

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
                    controller: _titleTeController,
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
                    controller: _descriptionTeController,
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
                  Visibility(
                    visible: _addNewTaskInPrograss == false,
                    replacement: const CenteredPrograssIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addNewTask();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
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
        await NetworkCaller.postRequest(Urls.createTask, body: requestData);

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
  }

  void _clearTextFields() {
    _titleTeController.clear();
    _descriptionTeController.clear();
  }

  @override
  void dispose() {
    _titleTeController.dispose();
    _descriptionTeController.dispose();
    super.dispose();
  }
}
