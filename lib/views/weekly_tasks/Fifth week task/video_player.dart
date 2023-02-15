import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/single_video_player.dart';

import '../../../models/music.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  List<Video> allVideo = [];

  getSingleFile({required AssetEntity file}) async {
    File f = await file.file as File;

    return f;
  }

  getSingleThub({required AssetEntity file}) async {
    Uint8List? f = await file.thumbnailData;

    return f;
  }

  pickAudio() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.video);

      final List<AssetEntity> entities = await paths[0].getAssetListPaged(
        page: 0,
        size: 200,
      );

      for (int i = 0; i < entities.length; i++) {
        File file = await getSingleFile(file: entities[i]);
        Uint8List files = await getSingleThub(file: entities[i]);
        setState(() {});

        allVideo.add(Video(name: entities[i].title ?? "Music", title: entities[i].createDateTime.toString(), files: file, file: files));
      }

      log(allVideo.length.toString());

      log("FileList: $entities");

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Video Player"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (allVideo.isNotEmpty)
                  ? SizedBox(
                      height: 690,
                      child: ListView.builder(
                        itemCount: allVideo.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Colors.grey.shade200,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleVideoPlayerPage(
                                      index: index,
                                      music: allVideo,
                                    ),
                                  ),
                                );
                              },
                              tileColor: Colors.blue.shade50,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              leading: SizedBox(
                                width: 100,
                                child: Image(
                                  image: MemoryImage(allVideo[index].file),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              isThreeLine: true,
                              title: Text(allVideo[index].name, maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle: Text(allVideo[index].title),
                            ),
                          );
                        },
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
