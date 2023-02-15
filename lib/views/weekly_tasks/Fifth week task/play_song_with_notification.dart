import 'dart:io';
import 'package:flutter/material.dart';
import 'package:training_app/models/music.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

class PlaySongWithNotification extends StatefulWidget {
   PlaySongWithNotification({Key? key, required this.music, required this.name, required this.allSongs, required this.id}) : super(key: key);

  File music;
  String name;
  int id;
  List<Music> allSongs;

  @override
  State<PlaySongWithNotification> createState() => _PlaySongWithNotificationState();
}

class _PlaySongWithNotificationState extends State<PlaySongWithNotification> {

  // final assetsAudioPlayer = AssetsAudioPlayer();
  int i = 0;

  @override
  void initState() {
    // assetsAudioPlayer.open(
      // Audio.file(FILE_URI),
    // );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.allSongs[i].name.toString().split(".")[0],
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
