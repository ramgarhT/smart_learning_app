import 'package:ai_learning_app/controllers/user.auth.controller.dart';
import 'package:ai_learning_app/pages/users/signup_page.dart';
import 'package:ai_learning_app/pages/users/user_homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key});

  @override
  State<UserSignIn> createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  UserAuthController authController = Get.put(UserAuthController());
  
  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;
    final RxBool hidepassword = true.obs;



    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              // SizedBox(height: mediaSize.height * 0.25,),
          
              Container(
                height: mediaSize.height * 0.2,
                child: Image.asset('assets/images/edu_logo.PNG'),
              ),
          
              SizedBox(height: mediaSize.height * 0.1,),
          
              // username 
              Container(
                width: mediaSize.width * 0.8,
                child: TextField(            
                  controller: _usernameController,
                  decoration: InputDecoration(
                  hintText: 'Username',
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
          
              // password
              Container(
                width: mediaSize.width * 0.8,
                child: Obx(() =>
                  TextField(
                    obscureText: hidepassword.value,
                    controller: _passwordController,
                    decoration: InputDecoration(
                    hintText: 'Passowrd',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.amber, width: 4),
                      borderRadius: BorderRadius.circular(12),                  
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Obx(() => hidepassword.value? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                      color: Colors.black,
                      onPressed: () {
                        hidepassword.value = !hidepassword.value;
                        print(hidepassword.value);
                      },
                    )
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
                    print("🔵 Sign In button clicked");
                    print("Username: ${_usernameController.text}");
                    print("Password: ${_passwordController.text}");
                     await authController.user_signin(_usernameController.text.trim().toString(), _passwordController.text.trim().toString(), context);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                  ),
                  child: Center(child: Obx(() => authController.isSigning.value? CircularProgressIndicator() : Text("Sign In", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),))            
                ),
              ),


              SizedBox(height: 5,),


              // siginUp btn
              Container(
                width: mediaSize.width * 0.4,
                child: TextButton(        
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserSignUp()));
                  },
                  child: const Text("create an account", style: TextStyle(color: Color.fromARGB(255, 15, 73, 121)),),
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}