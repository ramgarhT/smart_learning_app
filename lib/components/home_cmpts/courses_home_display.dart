import 'package:ai_learning_app/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HomeCoursesDisplay extends StatefulWidget {
  const HomeCoursesDisplay({super.key});

  @override
  State<HomeCoursesDisplay> createState() => _HomeCoursesDisplayState();
}

class _HomeCoursesDisplayState extends State<HomeCoursesDisplay> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // Update UI after initialization
    });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16/9,
      autoPlay: true,
      allowFullScreen: true,
      draggableProgressBar: true,
      looping: true,
    );
    _controller.play();
  }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    var mediaSize = MediaQuery.of(context).size;

    return Container(
      color: AppTheme.pYellow,
      child: SingleChildScrollView(child: Column(
        children: List.generate(3, (index) {
          return Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first row ...
                    Container(
                      child: ListTile(
                        leading: const CircleAvatar(
                            radius: 35,
                            child: Text('T'),
                        ),
                        title: const Text('Taher ramgarh'),
                        subtitle: const Text('12h ago', style: TextStyle(color: AppTheme.psBlack3),),
                        trailing: Container(
                          width: mediaSize.width * 0.25,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: (){},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppTheme.psBlack1)
                                  ),
                                  child: const Text('Follow', style: TextStyle(fontSize: 15, color: AppTheme.psBlack5,),),
                                ),
                            ],),
                          ),
                        ),
                      ),
                    ),
                
                    // course video...
                    Container(
                      padding: const EdgeInsets.only(left: 20,),
                      height: mediaSize.height * 0.25,
                      width: mediaSize.width * 0.9,
                      // color: AppTheme.pBlue,
                      child: AspectRatio(
                        aspectRatio: _chewieController.videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController),
                      )
                    ),
                
                
                    // about or desc...
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 20, right: 20),
                      child: Text('MERN stack full course #coding #MERN #developer #coding #MERN #developer #coding #MERN ', softWrap: true,),
                    ),


                    // views of video...
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 8.0, bottom: 8.0),
                      child: Text('20k views', style: TextStyle(color: AppTheme.psBlack5),),
                    ),

                    // second row actions...
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 8.0,),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(20, 30)),
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(207, 255, 255, 255))
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite_outline_sharp, size: 20, color: AppTheme.pBlack,),
                                SizedBox(width: mediaSize.width * 0.01,),
                                const Text('10', style: TextStyle(color: AppTheme.pBlack),)
                              ],
                            )
                          ),
                          SizedBox(width: mediaSize.width * 0.01,),
                          ElevatedButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(20, 30)),
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(207, 255, 255, 255))
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.bubble_chart_outlined, size: 20, color: AppTheme.pBlack,),
                                SizedBox(width: mediaSize.width * 0.01,),
                                const Text('5', style: TextStyle(color: AppTheme.pBlack),)
                              ],
                            )
                          ),
                          SizedBox(width: mediaSize.width * 0.01,),
                          ElevatedButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(20, 30)),
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(207, 255, 255, 255))
                            ),
                            child: const Icon(Icons.share, size: 20, color: AppTheme.pBlack,),
                          ),
                        ],
                      ),
                    ),

                    // comments section row...
                  ],
                ),
              ),
            ),
          );
        })
      ),),
    );
  }
}