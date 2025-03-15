import 'package:ai_learning_app/app.theme.dart';
import 'package:ai_learning_app/controllers/home_controller.dart';
import 'package:ai_learning_app/controllers/user.auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../pages/users/users_profile_screen.dart';

class UsersToFollow extends StatefulWidget {
  const UsersToFollow({super.key});

  @override
  State<UsersToFollow> createState() => _UsersToFollowState();
}

class _UsersToFollowState extends State<UsersToFollow> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;
    var allUsers = GetStorage().read('allUsers');
    var _isFollowing = false;

    String userFname (String name) {
      String username = name.split(' ')[0].capitalize.toString();
      String userFname = username.split('')[0].capitalize.toString();
      return userFname;
    }

    

    return Container(
      // color: Colors.red,
      child: SingleChildScrollView(child: Column(
        children: [

          SizedBox(height: mediaSize.height * 0.02,),

          Container(
            padding: EdgeInsets.all(4),
            height: mediaSize.height * 0.31,
            width: mediaSize.width * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('People to Follow', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Get.put(HomeController()).getAllUsers();
                        
                        setState(() {
                        });
                      },
                      icon: const Icon(Icons.replay_outlined,),
                    ),
                  ],
                ),
            
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: mediaSize.height * 0.23,
                    width: mediaSize.width * 1.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allUsers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(UsersProfileScreen(selectedUser: allUsers[index]));
                          },
                          child: Container(
                            height: mediaSize.height * 0.23,
                            width: mediaSize.width * 0.35,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(child: Text(userFname(allUsers[index]['username'].toString())),),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(allUsers[index]['username'].toString(), style: TextStyle(color: AppTheme.pBlack),),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('17.8k Followers', style: TextStyle(fontSize: 11, color: AppTheme.psBlack3),),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await homeController.followTheUser(allUsers[index]['_id']);
                                      setState(() {});
                                      // Get.to(UsersProfileScreen(selectedUser: allUsers[index],));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(AppTheme.psBlack5)
                                    ),

                                    child: _isFollowing == true? Center(child: CircularProgressIndicator(),) :Text(homeController.checkIfUserIsFollowed(allUsers[index]['_id'])? 'Following' : 'Follow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack1,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],),
          ),

          Container(
            padding: EdgeInsets.all(4),
            height: mediaSize.height * 0.2,
            width: mediaSize.width * 1.0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Container(
                        color: AppTheme.psYellow2,
                        height: mediaSize.height * 0.05,
                        width: mediaSize.width * 0.3,
                        child: Center(child: Text('Meet Mufaddal', style: TextStyle(fontWeight: FontWeight.w500),)),
                      ),
                      SizedBox(height: mediaSize.height * 0.008,),
                      const Text('Writer, Scientist, Doctor', style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.psBlack3),)
                    ],),

                    Stack(
                      children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Image.network('https://imgs.search.brave.com/-EAsE6oIdDYaZfHe7j2_pVYJtWBHP_l6c6xTipkktd0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2RmLzQ4/LzBmL2RmNDgwZmUx/ZGI5MGViMmI1NzIy/Yjg1Mzg2MGJkNzVl/LmpwZw')
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: ElevatedButton(
                              onPressed: (){},
                                child: Text('Follow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack1,),),
                                style: ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all(AppTheme.psBlack5)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],)
                
                  ],
                ),
              ),
            ),
          ), 

          Container(
            padding: EdgeInsets.all(4),
            height: mediaSize.height * 0.3,
            width: mediaSize.width * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Teams to Follow', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                ),
            
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) {
                      return Container(
                        height: mediaSize.height * 0.23,
                        width: mediaSize.width * 0.35,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(child: Text('T'),),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Team', style: TextStyle(color: AppTheme.pBlack),),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('10.2k Followers', style: TextStyle(fontSize: 11, color: AppTheme.psBlack3),),
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
                      );
                    }),
                  ),
                )
              ],),
          ),
        ],
      ),),
    );
  }
}



