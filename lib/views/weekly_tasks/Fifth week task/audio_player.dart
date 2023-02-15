import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:training_app/models/music.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/show_recording.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/single_audio_playing.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  List<Music> allMusic = [];

  getSingleFile({required AssetEntity file}) async {
    File f = await file.file as File;

    return f;
  }

  pickAudio() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.audio);

      final List<AssetEntity> entities = await paths[0].getAssetListPaged(
        page: 0,
        size: 200,
      );

      print(entities.length);

      for (int i = 0; i < entities.length; i++) {
        File file = await getSingleFile(file: entities[i]);
        setState(() {});
        allMusic.add(Music(name: entities[i].title ?? "Music", title: entities[i].createDateTime.toString(), files: file, id: i));
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pickAudio();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Audio Player"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecordListPage(),
            ),
          );
        },
        child: const Icon(CupertinoIcons.line_horizontal_3),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (allMusic.isNotEmpty)
                ? SizedBox(
                    height: 692,
                    child: ListView.builder(
                      itemCount: allMusic.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: Colors.blue.shade50,
                          child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleAudioPlayer(
                                    id: allMusic[index].id,
                                    allSongs: allMusic,
                                    name: allMusic[index].name,
                                    music: allMusic[index].files,
                                  ),
                                ),
                              );
                            },
                            leading: const Image(
                              image: NetworkImage(
                                "https://i.pinimg.com/originals/ae/2e/56/ae2e5651b74a00d5d31b8c6453fa3ebb.png",
                              ),
                            ),
                            tileColor: Colors.blue.shade50,
                            isThreeLine: true,
                            title: Text(allMusic[index].name, maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text(allMusic[index].title),
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
