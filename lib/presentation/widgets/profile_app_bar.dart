import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app.dart';
import '../controller/auth_controller.dart';
import '../screen/auth/sign_in_screen.dart';
import '../screen/update_profile_screen.dart';
import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) =>  const UpdateProfileScreen()));
      },
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blue,
          // backgroundImage: MemoryImage(base64Decode(AuthController.userData!.photo!)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                        (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    ),
  );
}
