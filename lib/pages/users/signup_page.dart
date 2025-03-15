import 'package:ai_learning_app/controllers/user.auth.controller.dart';
import 'package:ai_learning_app/pages/users/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {

    UserAuthController authController = Get.put(UserAuthController());
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _ageController = TextEditingController();
    final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    final mediaSize = MediaQuery.of(context).size;
    final RxBool hidepassword = false.obs;


    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              // SizedBox(height: mediaSize.height * 0.25,),
          
              Container(
                height: mediaSize.height * 0.15,
                child: Image.asset('assets/images/edu_logo.PNG'),
              ),
          
              SizedBox(height: mediaSize.height * 0.04,),
          
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
              
              SizedBox(height: mediaSize.height * 0.015,),
          
              // email
              Container(
                width: mediaSize.width * 0.8,
                child: TextField(            
                  controller: _emailController,
                  decoration: InputDecoration(
                  hintText: 'Email',
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
          
              // Age
              Container(
                width: mediaSize.width * 0.8,
                child: TextField(
                  keyboardType: TextInputType.number,            
                  controller: _ageController,
                  decoration: InputDecoration(
                  hintText: 'Age',
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
                    await authController.user_signup(
                      _usernameController.text.trim().toString(),
                      _emailController.text.trim().toString(),
                      _ageController.text.trim().toString(),
                      _passwordController.text.trim().toString(),
                      context
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                  ),
                  child: Center(child: Obx(() => authController.isSigning.value? CircularProgressIndicator() : Text("Sign Up", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),))            
                ),
              ),


              SizedBox(height: 5,),


              // siginUp btn
              Container(
                width: mediaSize.width * 0.6,
                child: TextButton(        
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserSignIn()));
                  },
                  child: const Text("Sign In to an existing account", style: TextStyle(color: Color.fromARGB(255, 15, 73, 121)),),
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}