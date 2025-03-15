import 'dart:convert';

import 'package:ai_learning_app/pages/users/signin_page.dart';
import 'package:ai_learning_app/global_variables.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../pages/users/user_homepage.dart';

class UserAuthController extends GetxController {

  RxBool isSigning = false.obs;
  var cUser;

  Future<void> _showMyDialog(context, title, content, actions) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: actions
        );
      },
    );
  }

  // user signup...
  Future user_signup (username, email, age, password, context) async {
    try {
      print('in user signnup func');
      isSigning.value = true;
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      var data = {
        'username': username,
        'email': email,
        'age': age,
        'password': password,
        "clientType": kIsWeb ? "web" : "mobile",
        "fcm_token": fcmToken
      };
      
      print('🔵 Sending request to: http://${GlobalVariables.ipAddress}:5000/user/signin');
      print('🟢 Request Body: $data');
      
      final response = await Dio().post('${GlobalVariables.ipAddress}/user/signup', data: data);
      print('🟢 after');

      if (response.statusCode == 201) {
          var resData = response.data;
          cUser = resData['data']['user'];
          GetStorage().write('cUser', cUser);
          GetStorage().write('token', cUser['token']);
          GetStorage().write('isLoggedIn', true );
          print(resData['data']['tokenExpDate']);
          if (resData['data']['tokenExpDate'] != null) {
            var tokenExpDate = resData['data']['tokenExpDate'];
            GetStorage().write('tokenExpDate', tokenExpDate);
          } else {
            print("🚨 Warning: tokenExpDate is null");
          }

          var user = GetStorage().read('cUser');
          var token = GetStorage().read('token');
          print('This is var cUser : $cUser');
          print('This is local Get storage cUser : $user');
          print('This is local Get storage user token : ${resData['data']['token']}');
          
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserHomepage()));
        } else {
          var resMsg = response.data['message'];
          isSigning.value = false;
          return await _showMyDialog(context, '', Text(resMsg), null);
        }

        isSigning.value = false;
      
    } catch (e) {
      print('USER SIGNUP ERROR => $e');
      isSigning.value = false;
    }
  }



    // user signin func...
  Future user_signin (username, password, context) async {


      try {
        print('in user signnin func');
        isSigning.value = true;
        String? fcmToken = await FirebaseMessaging.instance.getToken();

        final data = {"username": username, "password": password, "fcm_token": fcmToken ,"clientType": kIsWeb ? "web" : "mobile"};

        print('🔵 Sending request to: http://${GlobalVariables.ipAddress}:5000/user/signin');
        print('🟢 Request Body: $data');

        final response = await Dio().post('${GlobalVariables.ipAddress}/user/signin', data: data);

        print('in user signnin func 2');

        if (response.statusCode == 200) {
          var resData = response.data;
          var dateTime = DateTime.now();
          var tokenCreatedAtTime = dateTime.toString();
          cUser = resData['data']['user'];
          GetStorage().write('cUser', cUser);
          GetStorage().write('token', resData['data']['token']);
          GetStorage().write('isLoggedIn', true );
          GetStorage().write('expiresIn', resData['data']['expiresIn']);
          GetStorage().write('tokenCreatedAt', tokenCreatedAtTime);
          var user = GetStorage().read('cUser');
          var token = GetStorage().read('token');
          var expiresIn = GetStorage().read('expiresIn');
          var tokenCreatedAt = GetStorage().read('tokenCreatedAt');
          print('This is var cUser : $user');
          print('This is var token : $token');
          print('This is var expiresIn : $expiresIn');
          print('This is var tokenCreatedAt : $tokenCreatedAt');

          
          
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserHomepage()));
        } else {
          print(response.data['message']);
          isSigning.value = false;
          return await _showMyDialog(context, '', Text(response.data['message']), null);
        }

        isSigning.value = false;
      } catch (e) {
        isSigning.value = false;
        if (e is DioError) {
          print('Dio Error Type: ${e.type}');
          print('Dio Error Message: ${e.message}');
          if (e.response != null) {
            print('Dio Error Status: ${e.response?.statusCode}');
            print('Dio Error Data: ${e.response?.data}');
          }
        }
        print('Error is => $e');
        return await _showMyDialog(context, '', Text("Connection error: $e"), null);
      }
    }


  signOut() {
    GetStorage().write('cUser', null);
    GetStorage().write('token', null);
    GetStorage().write('isLoggedIn', false); // This was missing
    GetStorage().write('expiresIn', null); // This was missing
    GetStorage().write('tokenCreatedAt', null); // This was missing
    GetStorage().write('tokenExpDate', null);
    Get.offAll(() => UserSignIn());
  }

}