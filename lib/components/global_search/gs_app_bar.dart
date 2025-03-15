import 'package:ai_learning_app/components/home_cmpts/courses_home_display.dart';
import 'package:ai_learning_app/components/home_cmpts/following_home_cmpt.dart';
import 'package:flutter/material.dart';

import '../../app.theme.dart';

class GSAppBar extends StatelessWidget {
  const GSAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final mediaSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          // padding: const EdgeInsets.only(left: 15, right: 15),
          height: mediaSize.height * 0.23,
          // color: AppTheme.pBlue,
          child: SingleChildScrollView(
            child: Column(children: [
            
              SizedBox(height: mediaSize.height * 0.06,),
              
              // row 1
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const Text('Discover', style: TextStyle(
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
                        color: Color.fromARGB(255, 235, 195, 36)
                      ),
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text('Get', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(width: mediaSize.width * 0.02,),
                        const Icon(Icons.star_rate_rounded, ),
                      ],),),
                    ),
                  )
                        ]),
              ),
            
              SizedBox(height: mediaSize.height * 0.015,),
            
              Divider(color: AppTheme.psBlack1,),
            
              SizedBox(height: mediaSize.height * 0.01,),
              
              Container(
                height: mediaSize.height * 0.055,
                width: mediaSize.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: AppTheme.psBlack2),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Search what you want...', style: TextStyle(color: AppTheme.psBlack3, fontSize: 15)),
                    ),
                    IconButton(
                      onPressed: () => print('btn clicked'),
                      icon: Icon(Icons.mic_none),
                    ),
                  ],
                ),
              ),
            
            
              
            
              ]),
          ),
        ),

        Container(
          height: mediaSize.height * 0.65,
          child: SingleChildScrollView(
            child: Column(
              children: [
                UsersToFollow(),
              ],
            ),
          ),
        )
      ],
    );
  }
}