import 'package:ai_learning_app/global_variables.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreatingNewCoursesController extends GetxController {

  var subjects = [];
  Dio dio = Dio();

  //getting all subjects for creating a course...
  getAllSubjects () async {
    try {

      final subjs = await dio.get('${GlobalVariables.ipAddress}/subjects');
      subjects = subjs.data['data']['subjects'];
      // print(subjects);
      
    } catch (e) {
      print('getAllSubjects error : $e');
    }
  }

  //getting all subjects for creating a course...
  getUserCourses () async {
    try {
      var userId = GetStorage().read('cUser')['_id'];
      final userAllCourses = await dio.get('${GlobalVariables.ipAddress}/courses/$userId');
      GetStorage().write('userCourses', userAllCourses.data['data']['courses']);
      print("this is my userCourses : ${GetStorage().read('userCourses')}");
      return userAllCourses.data['data']['courses'];
      
    } catch (e) {
      print('getAllSubjects error : $e');
    }
  }

  getAllCourses () async {
    try {

      final allCourses = await dio.get('${GlobalVariables.ipAddress}/courses');
      GetStorage().write('allCourses', allCourses.data['data']['courses']);
      print("This is my all courses : ${GetStorage().read('allCourses').length}");
      return allCourses.data['data']['courses'];
      
    } catch (e) {
      print('getAllCourses error : $e');
    }
  }

  // create a new user course...
  Future createNewCourse (course, desc, subjects) async {
    try {

      var createdBy = GetStorage().read('cUser')['_id'];
      var data = {
        "course": course,
        "desc": desc,
        "subjects": subjects,
        "createdBy": createdBy
      };
      dio.options.headers["Content-Type"] = "application/json"; // Ensure JSON format
      final newCourse = await dio.post('${GlobalVariables.ipAddress}/course-create', data: data);
      print(newCourse.data['data']);
      
    } catch (e) {
      print("createNewCourse error : $e");
    }
  }

}