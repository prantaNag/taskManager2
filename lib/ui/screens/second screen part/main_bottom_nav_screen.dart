import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/add_button_screen.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/cancled_task_screen.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/completed_task_screen.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/new_task_screen.dart';
import 'package:taskmanager/ui/screens/second%20screen%20part/process_task_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    ProcessTaskScreen(),
    CancledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.amberAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_sharp),
            label: 'New task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Process',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancled',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButtonScreen,
        child: Icon(
          Icons.add,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  void _onTapAddButtonScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddButtonScreen(),
      ),
    );
  }
}
