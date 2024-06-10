import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';

class AddButtonScreen extends StatefulWidget {
  const AddButtonScreen({super.key});

  @override
  State<AddButtonScreen> createState() => _AddButtonScreenState();
}

class _AddButtonScreenState extends State<AddButtonScreen> {
  final TextEditingController _titleTeController = TextEditingController();
  final TextEditingController _descriptionTeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar(),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTeController,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _descriptionTeController,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 14,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTeController.dispose();
    _descriptionTeController.dispose();
    super.dispose();
  }
}
