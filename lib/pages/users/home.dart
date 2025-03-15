import 'package:ai_learning_app/components/home_cmpts/top_app_bar.dart';
import 'package:ai_learning_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    HomeController homeController = Get.put(HomeController());

    return Container(
      child: Column(children: [

        const HomeTopAppBar(),
        Obx(() => Expanded(child: homeController.homeScreens[homeController.selectedIndex.value])),

      ],),
    );
  }
}