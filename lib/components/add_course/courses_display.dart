import 'package:ai_learning_app/controllers/creating_new_course_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.theme.dart';

class NewCoursesDisplay extends StatefulWidget {
  const NewCoursesDisplay({super.key});

  @override
  State<NewCoursesDisplay> createState() => _NewCoursesDisplayState();
}

class _NewCoursesDisplayState extends State<NewCoursesDisplay> {
  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size;
    CreatingNewCoursesController creatingNewCoursesController = Get.put(CreatingNewCoursesController());


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text('Users courses history', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
        ),

        Container(
          height: mediaSize.height * 0.3,
          width: mediaSize.width * 0.9,
          child: FutureBuilder(
            future: creatingNewCoursesController.getUserCourses(),
            builder: (context, snapshot) {
        
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No data available"));
              }
        
              // Ensure data is a list
              List<dynamic> data = snapshot.data as List<dynamic>? ?? [];
        
              if (data.isEmpty) {
                return const Center(child: Text("No courses found"));
              }
        
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
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
                                  child: Text(data[index]['course'], style: TextStyle(color: AppTheme.pBlack),),
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
                });
            }),
        ),
      ],
    );
  }
}