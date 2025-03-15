import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.theme.dart';
import '../../controllers/creating_new_course_controller.dart';
import '../../pages/users/user_homepage.dart';

class CourseTextFields extends StatefulWidget {
  const CourseTextFields({super.key});

  @override
  State<CourseTextFields> createState() => _CourseTextFieldsState();
}

class _CourseTextFieldsState extends State<CourseTextFields> {


  CreatingNewCoursesController creatingNewCoursesController = Get.put(CreatingNewCoursesController());
  
  @override
  void initState() {
    super.initState();
    creatingNewCoursesController.getAllSubjects();
    creatingNewCoursesController.getUserCourses();
  }

  final _courseName = TextEditingController();
  final _courseDesc = TextEditingController();
  final _courseSubj = TextEditingController();
  final _courseRanking = TextEditingController();
    List selectedOptionsId = []; // Stores selected options
    List<String> selectedOptionsNames = [];

      void _showMultiSelectDialog() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Select Options"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: creatingNewCoursesController.subjects.map((option) {
                        String subjectName = option["subject"] ?? "Unknown"; // Extract name
                        String subjectsId = option["_id"] ?? "Unknown"; // Extract name
                        return CheckboxListTile(
                          title: Text(subjectName),
                          value: selectedOptionsNames.contains(subjectName),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedOptionsId.add(option['_id']);
                                selectedOptionsNames.add(subjectName);
                              } else {
                                selectedOptionsId.removeWhere((element) => element == subjectsId);
                                print(selectedOptionsId);
                                selectedOptionsNames.remove(subjectName);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {

                        print("selectedOptions : $selectedOptionsId");
                        print("selectedOptionsnames : $selectedOptionsNames");
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
        ).then((_) {
              setState(() {}); // ✅ Updates main screen UI after dialog closes
            });
      }




  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // username 
                Center(
                  child: Container(
                    width: mediaSize.width * 0.8,
                    child: TextField(            
                      controller: _courseName,
                      decoration: InputDecoration(
                      hintText: 'Course name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.amber, width: 4),
                        borderRadius: BorderRadius.circular(12),                  
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                     ),              
                    ),
                  ),
                ),
                
                SizedBox(height: mediaSize.height * 0.015,),
            
                // email
                Container(
                  width: mediaSize.width * 0.8,
                  child: TextField(            
                    controller: _courseDesc,
                    decoration: InputDecoration(
                    hintText: 'Description about the course',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.amber, width: 4),
                      borderRadius: BorderRadius.circular(12),                  
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                   ),              
                  ),
                ),
        
                SizedBox(height: mediaSize.height * 0.015,),
            
                GestureDetector(
              onTap: (){
                 _showMultiSelectDialog();
              },
              child: Container(
                width: mediaSize.width * 0.8,
                height: mediaSize.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: AppTheme.psBlack3),
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: Center(child: Text(selectedOptionsNames.isEmpty? 'Select subjects you like': selectedOptionsNames.toString(), style: TextStyle(fontSize: 20, ),),),
              ),
            ),
        
                // SizedBox(height: mediaSize.height * 0.03,),
        
        
                Container(
                  width: mediaSize.width * 0.8,
                  child: TextField(
                    keyboardType: TextInputType.number,            
                    controller: _courseSubj,
                    decoration: InputDecoration(
                    hintText: 'Ranking',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.amber, width: 4),
                      borderRadius: BorderRadius.circular(12),                  
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                   ),              
                  ),
                ),
        
                SizedBox(height: mediaSize.height * 0.03,),
        
        
                // siginIn btn
                Container(
                  width: mediaSize.width * 0.8,
                  child: ElevatedButton(        
                    onPressed: () async {
                      print("selectedOptions are here to know : $selectedOptionsId");
                      await creatingNewCoursesController.createNewCourse(
                        _courseName.text.trim().toString(),
                        _courseDesc.text.trim().toString(),
                        selectedOptionsId
                      );
                      Get.offAll(UserHomepage());
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)
                    ),
                    child: Center(
                      child: selectedOptionsNames.isEmpty?
                            Text('select subject'):
                            Text('create course'),
                    )
                    ),            
                  ),
                
        ],),
      );
  }
}