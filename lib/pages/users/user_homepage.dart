import 'package:ai_learning_app/controllers/user.auth.controller.dart';
import 'package:ai_learning_app/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/bottom_navbar.controller.dart';
import '../../controllers/home_controller.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {

    // final mediaSize = MediaQuery.of(context).size;
    BottomNavController bottomNavController = Get.put(BottomNavController());
    HomeController homeController = Get.put(HomeController());
    homeController.getAllUsers();


    return Scaffold(
      body: Obx(() => bottomNavController.screens.value[bottomNavController.selectedIndex.value]),

      bottomNavigationBar: const FlashyNavBar()
    );
  }
}