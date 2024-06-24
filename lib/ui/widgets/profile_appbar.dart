import 'package:flutter/material.dart';
import 'package:taskmanager/ui/controllers/auth_controlres.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/update_profile_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';

AppBar profileAppbar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: const Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthControler.userdata?.fullName ?? " ",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Text(
            AuthControler.userdata?.email ?? " ",
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          await AuthControler.clearAllData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}
