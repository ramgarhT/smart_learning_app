import 'package:ai_learning_app/components/add_course/courses_display.dart';
import 'package:ai_learning_app/components/add_course/txt_fields_course.dart';
import 'package:flutter/material.dart';

class CreateNewCourse extends StatelessWidget {
  const CreateNewCourse({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Course"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(children: [
          CourseTextFields(),
          NewCoursesDisplay()
        ],),
      )
    );
  }
}