import 'dart:async';

import 'package:ai_learning_app/middlewares.dart';
import 'package:ai_learning_app/pages/users/create_new_course.dart';
import 'package:ai_learning_app/pages/users/signin_page.dart';
import 'package:ai_learning_app/pages/users/user_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../controllers/creating_new_course_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var storage = GetStorage();

  @override
  void initState() {
    super.initState();
    // Better to handle navigation in initState
    Timer(Duration(seconds: 3), () {
      checkAuth();
    });
  }

  void checkAuth() async {
    // Print all storage for debugging
    print("All storage values: ${GetStorage().getValues()}");
    
    // Put the middleware instance and run authorization
    final middlewares = Get.put(Middlewares());
    await middlewares.authorization();
  }


  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              SizedBox(height: mediaSize.height * 0.25,),
          
              Container(
                height: mediaSize.height * 0.3,
                child: Image.asset('assets/images/edu_logo.PNG'),
              ),
          
              SizedBox(height: mediaSize.height * 0.2,),
          
              const CircularProgressIndicator(color: Colors.blue, ),
          
            ],
          ),
        ),
      ),
    );
  }
}