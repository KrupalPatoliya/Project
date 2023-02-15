import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/records.dart';

class PlayRecordsPage extends StatefulWidget {
  PlayRecordsPage({Key? key, required this.name, required this.allSongs, required this.id}) : super(key: key);

  String name;
  int? id;
  List<Records> allSongs;

  @override
  State<PlayRecordsPage> createState() => _PlayRecordsPageState();
}

class _PlayRecordsPageState extends State<PlayRecordsPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPause = true;
  Duration? currentDuration;
  Duration? totalDuration;
  PlayerState playerState = PlayerState.paused;

  totalDurationFunction() async {
    totalDuration = await audioPlayer.getDuration();
  }

  int i = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      audioPlayer.play(DeviceFileSource(widget.allSongs[widget.id!].path)).then((value) {
        totalDurationFunction();
        setState(() {});
      });

      audioPlayer.onPlayerComplete.listen((event) {
        if (currentDuration!.inSeconds.toInt() == totalDuration!.inSeconds.toInt()) {
          i = i++;
          audioPlayer.play(DeviceFileSource(widget.allSongs[i].path)).then((value) {
            totalDurationFunction();
            setState(() {});
          });
        }
      });
    });
    // TODO: implement initState

    // audioPlayer.setReleaseMode(ReleaseMode.loop);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.allSongs[i].path.toString().split("/").last,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
              height: 200,
              width: 200,
              child: Image(
                image: NetworkImage(
                  "https://i.pinimg.com/originals/ae/2e/56/ae2e5651b74a00d5d31b8c6453fa3ebb.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    // String a = "#done #complete #ok yes";
                    // print("====================================");
                    // print("#".allMatches(a).length);
                    // print("====================================");
                    // await videoPlayerController.dispose();
                    if (i == 0) {
                      i = widget.allSongs.length;
                      i--;
                      audioPlayer.play(DeviceFileSource(widget.allSongs[i].path)).then((value) {
                        totalDurationFunction();
                        setState(() {});
                      });
                    } else {
                      i--;

                      audioPlayer.play(DeviceFileSource(widget.allSongs[i].path)).then((value) {
                        totalDurationFunction();
                        setState(() {});
                      });
                    }
                  },
                  child: const Icon(CupertinoIcons.backward_end_fill, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (currentDuration!.inSeconds < 10) {
                      } else {
                        audioPlayer.seek(Duration(seconds: currentDuration!.inSeconds - 10));
                      }
                    });
                  },
                  child: const Icon(CupertinoIcons.gobackward_10, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    if (isPause) {
                      audioPlayer.pause();
                      setState(() {
                        isPause = false;
                      });
                    } else {
                      audioPlayer.play(
                        DeviceFileSource(widget.allSongs[i].path),
                        position: Duration(seconds: currentDuration!.inSeconds),
                      );
                      setState(() {
                        isPause = true;
                      });
                    }
                  },
                  child: Icon((isPause == false) ? Icons.play_circle_rounded : Icons.pause_circle_filled, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (currentDuration!.inSeconds < 10) {
                      } else {
                        audioPlayer.seek(Duration(seconds: currentDuration!.inSeconds + 10));
                      }
                    });
                  },
                  child: const Icon(CupertinoIcons.goforward_10, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    if (i == widget.allSongs.length) {
                      i = 0;

                      audioPlayer.play(DeviceFileSource(widget.allSongs[i].path)).then((value) {
                        totalDurationFunction();
                        setState(() {});
                      });
                    } else {
                      i++;
                      audioPlayer.play(DeviceFileSource(widget.allSongs[i].path)).then((value) {
                        totalDurationFunction();
                        setState(() {});
                      });
                    }
                  },
                  child: const Icon(CupertinoIcons.forward_end_fill, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 40),
            StreamBuilder(
              stream: audioPlayer.onPositionChanged,
              builder: (context, AsyncSnapshot snapshot) {
                currentDuration = snapshot.data;

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Slider(
                          min: 0,
                          max: totalDuration!.inSeconds.toDouble(),
                          value: currentDuration!.inSeconds.toDouble(),
                          onChanged: (val) {
                            setState(() {
                              audioPlayer.onPlayerComplete.listen((event) {
                                totalDuration = currentDuration;
                                currentDuration = snapshot.data;
                              });
                              currentDuration = Duration(seconds: val.toInt());
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${currentDuration.toString().split(".")[0]}/${totalDuration.toString().split(".")[0]}",
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    audioPlayer.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }
}
