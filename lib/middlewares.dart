import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ai_learning_app/pages/users/signin_page.dart';
import 'package:ai_learning_app/pages/users/user_homepage.dart';

class Middlewares extends GetxController {

  Future<bool> authorization() async {
    try {
      var storage = GetStorage();
      
      // Uncomment the below line to view all stored values for debugging
      // print("ALL STORAGE: ${storage.getValues()}");
      
      var token = storage.read('token');
      var isLoggedIn = storage.read('isLoggedIn');
      var expiresIn = storage.read('expiresIn');
      var tokenCreatedAt = storage.read('tokenCreatedAt');
      
      print('Token: $token');
      print('isLoggedIn: $isLoggedIn');
      print('expiresIn: $expiresIn');
      print('tokenCreatedAt: $tokenCreatedAt');
      
      // Check if user is logged in with token
      if (token == null || isLoggedIn != true) {
        print('Not logged in or token missing');
        Get.offAll(() => UserSignIn());
        return false;
      }
      
      // If expiration data exists, check if token is still valid
      if (expiresIn != null && tokenCreatedAt != null) {
        try {
          // Extract the numeric value and time unit
          final RegExp numericRegex = RegExp(r'\d+');
          final RegExp unitRegex = RegExp(r'[a-zA-Z]+');
          
          final duration = int.parse(numericRegex.firstMatch(expiresIn)!.group(0)!);
          final unit = unitRegex.firstMatch(expiresIn)!.group(0)!;
          
          // Parse the token creation time
          DateTime createdAt = DateTime.parse(tokenCreatedAt);
          DateTime expirationTime;
          
          // Calculate when the token expires
          if (unit == "m") {
            expirationTime = createdAt.add(Duration(minutes: duration));
          } else if (unit == "h") {
            expirationTime = createdAt.add(Duration(hours: duration));
          } else if (unit == "s") {
            expirationTime = createdAt.add(Duration(seconds: duration));
          } else {
            throw Exception("Invalid time format");
          }
          
          print('Token expires at: $expirationTime');
          print('Current time: ${DateTime.now()}');
          
          // Check if token is expired
          if (DateTime.now().isAfter(expirationTime)) {
            print('Token has expired');
            storage.write('isLoggedIn', false);
            storage.write('token', null);
            Get.offAll(() => UserSignIn());
            return false;
          }
          
          print('Token is still valid');
          Get.offAll(() => UserHomepage());
          return true;
        } catch (e) {
          print('Error checking token expiration: $e');
          Get.offAll(() => UserHomepage()); // If we can't check, assume it's valid
          return true;
        }
      } else {
        // No expiration data, just check if logged in
        print('No expiration data. Using isLoggedIn only.');
        Get.offAll(() => UserHomepage());
        return true;
      }
    } catch (e) {
      print('Authorization error: $e');
      Get.offAll(() => UserSignIn());
      return false;
    }
  }
}