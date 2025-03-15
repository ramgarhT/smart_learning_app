import 'package:ai_learning_app/app.theme.dart';
import 'package:ai_learning_app/controllers/home_controller.dart';
import 'package:ai_learning_app/controllers/user.auth.controller.dart';
import 'package:ai_learning_app/pages/users/users_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTopAppBar extends StatelessWidget {
  const HomeTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;
    var txtBtnsName = ["Following", "Must Watch", "Popular", "Courses"];
    HomeController homeController = Get.put(HomeController());
    UserAuthController userAuthController = Get.put(UserAuthController());


    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: mediaSize.height * 0.2,
      // color: AppTheme.pBlue,
      child: Column(children: [

        SizedBox(height: mediaSize.height * 0.06,),
        
        // row 1
        Row(children: [
          const Text('Home', style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),

          SizedBox(width: mediaSize.width * 0.15,),
          
          GestureDetector(
            onTap: (){
              print('btn tapped!');
            },
            child: Container(
              width: mediaSize.width * 0.2,
              height: mediaSize.height * 0.045,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: AppTheme.pYellow
              ),
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text('Get', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(width: mediaSize.width * 0.02,),
                const Icon(Icons.star_rate_rounded, ),
              ],),),
            ),
          ),

          SizedBox(width: mediaSize.width * 0.01,),

          IconButton(
            onPressed: (){
              
            },
            icon: Icon(Icons.bookmark_border),
          ),

          SizedBox(width: mediaSize.width * 0.01,),

          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none),
          ),

          SizedBox(width: mediaSize.width * 0.01,),

          IconButton(
            onPressed: (){
              userAuthController.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
          
        ],),

        SizedBox(height: mediaSize.height * 0.015,),

        // row 2
        Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return TextButton(
                      onPressed: () {
                        homeController.selectedIndex.value = index;
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          homeController.selectedIndex.value == index
                              ? AppTheme.psBlack1 // Selected button
                              : null // Default state
                        ),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
                      ),
                      child: Text(
                        txtBtnsName[index],
                        style: TextStyle(
                          color: homeController.selectedIndex.value == index
                              ? AppTheme.pBlue // Highlight selected text
                              : AppTheme.psBlack2
                        ),
                      ),
                    );
                  }),
                )),

      ],),
    );
  }
}