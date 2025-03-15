import 'package:ai_learning_app/components/home_cmpts/courses_home_display.dart';
import 'package:ai_learning_app/components/home_cmpts/following_home_cmpt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../global_variables.dart';

class HomeController extends GetxController {

  Dio dio = Dio();
  RxInt selectedIndex = 0.obs;
  final List<Widget> homeScreens = const [
    UsersToFollow(),
    Center(child: Text("Must Watch Content", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    Center(child: Text("Popular Content", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    HomeCoursesDisplay()
  ];

  Future getCUser () async {
    var cUser = GetStorage().read('cUser');
    var user = await Dio().get('${GlobalVariables.ipAddress}/cUser/${cUser['_id']}');
    GetStorage().write('cUser', user.data['user']);
  }

  Future getAllUsers() async {
  try {
    var cUser = GetStorage().read('cUser');
    final users = await dio.get('${GlobalVariables.ipAddress}/users');
    List allUsers = users.data['users'];
    
    // Remove the current user from the list
    List allUsersFinal = allUsers.where((user) => user['_id'] != cUser['_id']).toList();
    
    // Store the filtered list
    GetStorage().write('allUsers', allUsersFinal);

    
    getCUser();
    
    return allUsersFinal;
  } catch (e) {
    print('getUsers error : $e');
    return [];
  }
}


  Future followTheUser (selectedUserId) async {
    try {

      var cUser = GetStorage().read('cUser');
      List userFollowing = cUser['following'];
      // Format the data properly as a JSON object
      print(selectedUserId);
      print(cUser);
      var data = {
        "_id": selectedUserId
      };

      if (userFollowing.contains(selectedUserId)) {
        final userToUnfollow = await Dio().patch("${GlobalVariables.ipAddress}/user/unfollow-req/${cUser['_id']}", data: data);
        await getCUser();
      } else {
        final userToFollow = await Dio().patch("${GlobalVariables.ipAddress}/user/follow-req/${cUser['_id']}", data: data);
        await getCUser();
      }

    } catch (e) {
      print('is $e');
    }
  }

  checkIfUserIsFollowed (selectedUserId) {
    var cUser = GetStorage().read('cUser');
    print(cUser);
    List followingList = cUser['following'];
    print('This is my followingList : $followingList');
    if (followingList.contains(selectedUserId)) {
      return true;
    } else {
      return false;
    }
  }
}