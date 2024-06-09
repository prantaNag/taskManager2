import 'package:flutter/material.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';

AppBar profileAppbar() {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(),
    ),
    title: const Column(
      children: [
        Text(
          'Mister Hulululu',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Text(
          'Hulullu@gmail.com',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.logout),
      ),
    ],
  );
}
