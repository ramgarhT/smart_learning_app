import 'package:ai_learning_app/app.theme.dart';
import 'package:ai_learning_app/controllers/bottom_navbar.controller.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashyNavBar extends StatelessWidget {
  const FlashyNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    BottomNavController bottomNavController = Get.put(BottomNavController());
    var selectedIndex = bottomNavController.selectedIndex.value;

    return Obx(
      () => FlashyTabBar(
       selectedIndex: bottomNavController.selectedIndex.value,
       showElevation: true,
       onItemSelected: (index) {
        bottomNavController.changeIndex(index);
       },
       items: [
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.house_fill),
            title: const Text('Home'),
            activeColor: AppTheme.pBlue,
            inactiveColor: AppTheme.pBlack
          ),
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.search),
            title: const Text('Search'),
            activeColor: AppTheme.pBlue,
            inactiveColor: AppTheme.pBlack
          ),
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.add),
            title: const Text('Add course'),
            activeColor: AppTheme.pBlue,
            inactiveColor: AppTheme.pBlack
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.work_history),
            title: const Text('history'),
            activeColor: AppTheme.pBlue,
            inactiveColor: AppTheme.pBlack
          ),
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.profile_circled),
            title: const Text('Profile'),
            activeColor: AppTheme.pBlue,
            inactiveColor: AppTheme.pBlack
          ),
        ],
      ),
    );
  }
}