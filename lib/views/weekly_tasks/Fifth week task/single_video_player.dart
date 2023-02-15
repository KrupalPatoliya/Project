import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/models/music.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayerPage extends StatefulWidget {
  SingleVideoPlayerPage({Key? key, required this.index, required this.music}) : super(key: key);
  List<Video> music;
  int index;

  @override
  State<SingleVideoPlayerPage> createState() => _SingleVideoPlayerPageState();
}

class _SingleVideoPlayerPageState extends State<SingleVideoPlayerPage> {
  late VideoPlayerController videoPlayerController;

  int i = 0;

  bool isTrue = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videoPlayerController = VideoPlayerController.file(widget.music[widget.index].files)
        ..initialize().then((value) {
          setState(() {});
        })
        ..play()
        ..setLooping(true);
      videoPlayerController.addListener(() {
        setState(() {});
      });
    });
    // TODO: implement initState
    super.initState();
    i = widget.index;
  }

  @override
  void deactivate() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    videoPlayerController.pause();
    videoPlayerController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.music[i].name.toString().split(".")[0],
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        height: 600,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            (videoPlayerController.value.isInitialized)
                ? (videoPlayerController.value.hasError)
                    ? const Text("Not Available")
                    : AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(
                          videoPlayerController,
                        ),
                      )
                : const Center(child: CircularProgressIndicator()),
            VideoProgressIndicator(
              videoPlayerController,
              allowScrubbing: true,
              colors: VideoProgressColors(playedColor: Colors.red, backgroundColor: Colors.grey.shade200),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (videoPlayerController.value.volume > 0) {
                        videoPlayerController.setVolume(0);
                      } else {
                        videoPlayerController.setVolume(10);
                      }
                    },
                    child: Icon((videoPlayerController.value.volume > 0) ? Icons.volume_up : Icons.volume_off, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () async {
                      // String a = "#done #complete #ok yes";
                      // print("====================================");
                      // print("#".allMatches(a).length);
                      // print("====================================");
                      // await videoPlayerController.dispose();
                      if (i == 0) {
                        i = widget.music.length;
                        await videoPlayerController.dispose();
                        videoPlayerController = VideoPlayerController.file(widget.music[i--].files)
                          ..initialize().then((value) {
                            setState(() {});
                          })
                          ..play()
                          ..setLooping(true);
                        videoPlayerController.addListener(() {
                          setState(() {});
                        });
                      } else {
                        await videoPlayerController.dispose();
                        videoPlayerController = VideoPlayerController.file(widget.music[i--].files)
                          ..initialize().then((value) {
                            setState(() {});
                          })
                          ..play()
                          ..setLooping(true);
                        videoPlayerController.addListener(() {
                          setState(() {});
                        });
                      }
                    },
                    child: const Icon(CupertinoIcons.backward_end_fill, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        videoPlayerController.seekTo(Duration(seconds: videoPlayerController.value.position.inSeconds - 10));
                      });
                    },
                    child: const Icon(CupertinoIcons.gobackward_10, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (videoPlayerController.value.isPlaying == true) {
                          videoPlayerController.pause();
                        } else {
                          videoPlayerController.play();
                        }
                      });
                    },
                    child: Icon((videoPlayerController.value.isPlaying != true) ? Icons.play_circle_rounded : Icons.pause_circle_filled,
                        color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        videoPlayerController.seekTo(
                          Duration(seconds: videoPlayerController.value.position.inSeconds + 10),
                        );
                      });
                    },
                    child: const Icon(CupertinoIcons.goforward_10, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () async {
                      // await videoPlayerController.dispose();
                      setState(() async {
                        if (i == widget.music.length) {
                          i = 0;

                          await videoPlayerController.dispose();
                          videoPlayerController = VideoPlayerController.file(widget.music[i++].files)
                            ..initialize().then((value) {
                              setState(() {});
                            })
                            ..play()
                            ..setLooping(true);
                          videoPlayerController.addListener(() {
                            setState(() {});
                          });
                        } else {
                          await videoPlayerController.dispose();
                          videoPlayerController = VideoPlayerController.file(widget.music[i++].files)
                            ..initialize().then((value) {
                              setState(() {});
                            })
                            ..play()
                            ..setLooping(true);
                          videoPlayerController.addListener(() {
                            setState(() {});
                          });
                        }
                      });
                    },
                    child: const Icon(CupertinoIcons.forward_end_fill, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () async {
                      if (isTrue) {
                        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                        isTrue = false;
                      } else {
                        await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                        isTrue = true;
                      }

                      setState(() {});
                    },
                    child: Icon((isTrue) ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
