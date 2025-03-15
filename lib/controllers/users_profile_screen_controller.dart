import 'package:ai_learning_app/pages/users/users_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersProfileScreenController extends GetxController {
  RxInt usersPostsCoursesDocs = 0.obs;
  List<String> usersPostsCoursesDocsNames = const [
    "Posts",
    "Courses",
    "Documents",
  ];
  List<Widget> usersPostsCoursesDocsScreens = const [
    UsersPostsDisplay(),
    UsersCoursesDisplay(),
    UsersDocsDisplay()
  ];
}