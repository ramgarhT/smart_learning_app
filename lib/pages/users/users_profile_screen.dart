import 'package:ai_learning_app/app.theme.dart';
import 'package:ai_learning_app/controllers/users_profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class UsersProfileScreen extends StatefulWidget {
  UsersProfileScreen({required this.selectedUser});

  var selectedUser;

  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}

class _UsersProfileScreenState extends State<UsersProfileScreen> {
  


  @override
  Widget build(BuildContext context) {
    
    UsersProfileScreenController usersProfileScreenController = Get.put(UsersProfileScreenController());
    HomeController homeController = Get.put(HomeController());
    var mediaSize = MediaQuery.of(context).size ;
    var _isFollowing = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedUser['username']),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none)
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert_rounded)
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://imgs.search.brave.com/ul1ELzJhn3eDT8eV6L6sFVf3Ca6nEr9s5DHA1JybFYE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5zcHJvdXRzb2Np/YWwuY29tL3VwbG9h/ZHMvMjAyMi8wNi9w/cm9maWxlLXBpY3R1/cmUuanBlZw'),
                ),

                Container(
                  width: mediaSize.width * 0.65,
                  // color: AppTheme.pYellow,
                  padding: EdgeInsets.all(20.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text('13', style: TextStyle(fontSize: 15, ),),
                        Text('Posts', style: TextStyle(fontSize: 13, color: AppTheme.psBlack3),)
                      ],),

                      Column(children: [
                        Text('205', style: TextStyle(fontSize: 15, ),),
                        Text('followers', style: TextStyle(fontSize: 13, color: AppTheme.psBlack3),)
                      ],),

                      Column(children: [
                        Text('200', style: TextStyle(fontSize: 15, ),),
                        Text('following', style: TextStyle(fontSize: 13, color: AppTheme.psBlack3),)
                      ],),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: mediaSize.height * 0.02),

            Text(widget.selectedUser['bio'].toString(), style: TextStyle(fontSize: 13, color: AppTheme.psBlack3),),

            SizedBox(height: mediaSize.height * 0.025),

            homeController.checkIfUserIsFollowed(widget.selectedUser['_id'])?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await homeController.followTheUser(widget.selectedUser['_id']);
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.psBlack5),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(mediaSize.width * 0.45))
                  ),
                  child: Text('Unfollow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack1,),),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await homeController.followTheUser(widget.selectedUser['_id']);
                    // setState(() {});
                    print('message the user');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.psBlack2),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(mediaSize.width * 0.45))
                  ),
                  child: Text('Message', style: TextStyle(fontSize: 15, color: AppTheme.psBlack5,),),
                ),
              ],
            ) :

            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isFollowing = true;
                });
                await homeController.followTheUser(widget.selectedUser['_id']);
                setState(() {
                  _isFollowing = false;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.psBlack5),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(mediaSize.width * 0.9))
              ),
              child: _isFollowing == true? Center(child: CircularProgressIndicator(),) : Text('Follow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack1,),),
            ),

            SizedBox(height: mediaSize.height * 0.025),

            
            // row 2
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return TextButton(
                  onPressed: () {
                    usersProfileScreenController.usersPostsCoursesDocs.value = index;
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      usersProfileScreenController.usersPostsCoursesDocs.value == index
                          ? AppTheme.psBlack1 // Selected button
                          : null // Default state
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                  ),
                  child: Text(
                    usersProfileScreenController.usersPostsCoursesDocsNames[index],
                    style: TextStyle(
                      color: usersProfileScreenController.usersPostsCoursesDocs.value == index
                          ? AppTheme.pBlue // Highlight selected text
                          : AppTheme.psBlack2
                    ),
                  ),
                );
              }),
            )),

            SizedBox(height: mediaSize.height * 0.02),

            Container(
              height: mediaSize.height * 0.42,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => usersProfileScreenController.usersPostsCoursesDocsScreens[usersProfileScreenController.usersPostsCoursesDocs.value])
                  ],
                ),
              ),
            ),
            

          ],
        ),
      )
    );
  }
}



// user posts...
class UsersPostsDisplay extends StatelessWidget {
  const UsersPostsDisplay({super.key});

  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size ;
    
    return Container(
      height: mediaSize.height * 0.43,
      child: GridView.builder(
        padding: EdgeInsets.all(2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to post detail screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(post: posts[index])));
            },
            child: Hero(
              tag: 'post_Taher ramgarh',
              child: Image.network(
                'https://imgs.search.brave.com/ul1ELzJhn3eDT8eV6L6sFVf3Ca6nEr9s5DHA1JybFYE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5zcHJvdXRzb2Np/YWwuY29tL3VwbG9h/ZHMvMjAyMi8wNi9w/cm9maWxlLXBpY3R1/cmUuanBlZw',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          );
        }
                        ),
    );
  }
}


// user courses...
class UsersCoursesDisplay extends StatelessWidget {
  const UsersCoursesDisplay({super.key});

  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size ;
    
    return Container(
      height: mediaSize.height * 0.43,
      child: GridView.builder(
        padding: EdgeInsets.all(2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to post detail screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(post: posts[index])));
            },
            child: Hero(
              tag: 'post_Taher ramgarh',
              child: Image.network(
                'https://imgs.search.brave.com/-EAsE6oIdDYaZfHe7j2_pVYJtWBHP_l6c6xTipkktd0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2RmLzQ4/LzBmL2RmNDgwZmUx/ZGI5MGViMmI1NzIy/Yjg1Mzg2MGJkNzVl/LmpwZw',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          );
        }
                        ),
    );
  }
}


// user docs ...
class UsersDocsDisplay extends StatelessWidget {
  const UsersDocsDisplay({super.key});

  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size ;
    
    return Container(
      height: mediaSize.height * 0.43,
      child: ListView(
          children: List.generate(3, (index) {
            // Sample document data
            final documentNames = [
              'Project Proposal.pdf',
              'Financial Report.pdf',
              'Meeting Minutes.pdf',
            ];
            final documentSizes = ['2.4 MB', '1.8 MB', '756 KB'];
            final documentDates = ['Mar 8, 2025', 'Mar 5, 2025', 'Feb 28, 2025'];
            
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                ),
              ),
              title: Text(documentNames[index]),
              subtitle: Text('${documentSizes[index]} • ${documentDates[index]}'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Show options menu
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.remove_red_eye),
                          title: const Text('View'),
                          onTap: () {
                            Navigator.pop(context);
                            // Add view document logic
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.download),
                          title: const Text('Download'),
                          onTap: () {
                            Navigator.pop(context);
                            // Add download logic
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.share),
                          title: const Text('Share'),
                          onTap: () {
                            Navigator.pop(context);
                            // Add share logic
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              onTap: () {
                // Open PDF document
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening ${documentNames[index]}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            );
          }),
      ),
    );
  }
}


