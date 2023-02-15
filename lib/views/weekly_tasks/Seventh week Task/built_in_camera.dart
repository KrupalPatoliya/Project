import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:training_app/models/music.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/image_full_screen.dart';

class BuiltInCameraPage extends StatefulWidget {
  const BuiltInCameraPage({Key? key}) : super(key: key);

  @override
  State<BuiltInCameraPage> createState() => _BuiltInCameraPageState();
}

class _BuiltInCameraPageState extends State<BuiltInCameraPage> {
  List<ImageFile> allImage = [];

  getSingleFile({required AssetEntity file}) async {
    File f = await file.file as File;

    return f;
  }

  getSingleThumb({required AssetEntity file}) async {
    Uint8List? f = await file.thumbnailData;

    return f;
  }

  pickImage() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.all);

      final List<AssetEntity> entities = await paths[0].getAssetListPaged(
        page: 0,
        size: 6000,
      );

      for (int i = 0; i < entities.length; i++) {
        File file = await getSingleFile(file: entities[i]);
        Uint8List files = await getSingleThumb(file: entities[i]);
        setState(() {});
        allImage.add(
          ImageFile(
            name: entities[i].title ?? "Image",
            title: entities[i].createDateTime.toString(),
            files: file,
            id: i,
            file: files,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pickImage();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Gallery",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (allImage.isNotEmpty)
                ? SizedBox(
                    height: 660,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemCount: allImage.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageFullScreen(
                                  index: index,
                                  image: allImage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.white24,
                            child: Image(
                              image: MemoryImage(allImage[index].file),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text("Loading....", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
          ],
        ),
      ),
    );
  }
}
