import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app.theme.dart';
import '../../controllers/creating_new_course_controller.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size;
    CreatingNewCoursesController creatingNewCoursesController = Get.put(CreatingNewCoursesController());
    var listOfUserCourses = GetStorage().read('userCourses');
    creatingNewCoursesController.getUserCourses();
    creatingNewCoursesController.getAllCourses();

    return Container(
      height: 400,
      width: 400,
      color: Colors.red,
      child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfUserCourses.length,
                itemBuilder: (context, index) {
                  return Container(
                padding: EdgeInsets.all(4),
                height: mediaSize.height * 0.3,
                // width: mediaSize.width * 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Row(
                      children: [Container(
                          height: mediaSize.height * 0.23,
                          width: mediaSize.width * 0.35,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(child: Text('T'),),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(listOfUserCourses[index]['course'], style: TextStyle(color: AppTheme.pBlack),),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('17.8k Followers', style: TextStyle(fontSize: 11, color: AppTheme.psBlack3),),
                                ),
                                ElevatedButton(
                                  onPressed: (){},
                                  child: Text('Follow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack1,),),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppTheme.psBlack5)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )]
                      
                      ),
                  ],),
              );
                }),
    );
  }
}