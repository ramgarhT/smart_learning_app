import 'package:ai_learning_app/pages/users/create_new_course.dart';
import 'package:ai_learning_app/pages/users/home.dart';
import 'package:ai_learning_app/pages/users/search_global_page.dart';
import 'package:ai_learning_app/pages/users/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList<Widget> screens = <Widget>[
    Home(),
    GlobalSearchScreen(),
    CreateNewCourse(),
    Center(child: Text("Your Work History")),
    UserProfile(),
  ].obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    print(selectedIndex.value);
  }
}