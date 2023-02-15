import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class DefaultCamera extends StatefulWidget {
  const DefaultCamera({Key? key}) : super(key: key);

  @override
  State<DefaultCamera> createState() => _DefaultCameraState();
}

class _DefaultCameraState extends State<DefaultCamera> {
  ImagePicker _picker = ImagePicker();
  File? imageFile;
  XFile? image;

  File? imageFile1;
  XFile? image1;
  VideoPlayerController? _controller;

  bool isPlay = true;

  permisionHendler() async {
    Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      openAppSettings();
    }
    if (await Permission.location.isRestricted) {
      Permission.camera.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _picker = ImagePicker();
    permisionHendler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Default Camera and Gallery"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              ClipOval(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child:
                      (imageFile == null) ? const Icon(Icons.camera_alt, size: 60, color: Colors.white70) : Image.file(imageFile!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey.shade800,
                    context: context,
                    isDismissible: true,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  image = await _picker.pickImage(source: ImageSource.camera);

                                  if (image != null) {
                                    setState(() {
                                      imageFile = File(image!.path);
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(color: Colors.white70),
                                    child: const Icon(Icons.camera_alt, size: 40, color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Camera",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  image = await _picker.pickImage(source: ImageSource.gallery);

                                  if (image != null) {
                                    setState(() {
                                      imageFile = File(image!.path);
                                    });
                                  }

                                  Navigator.of(context).pop();
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(color: Colors.white70),
                                    child: const Icon(Icons.filter_rounded, size: 40, color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Gallery",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Text("Image Picker", style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              (imageFile1 != null)
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(
                              _controller!,
                            ),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            onPressed: () {
                              setState(() {
                                if (_controller?.value.isPlaying == true) {
                                  _controller?.pause();
                                } else {
                                  _controller?.play();
                                }
                              });
                            },
                            icon: Icon(
                              _controller?.value.isPlaying == true ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                          colors: VideoProgressColors(playedColor: Colors.red, backgroundColor: Colors.grey.shade200),
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ],
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                      child: const Icon(Icons.video_camera_back_outlined, size: 60, color: Colors.white)),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey.shade800,
                    context: context,
                    isDismissible: true,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  image1 = await _picker.pickVideo(source: ImageSource.camera);

                                  if (image1 != null) {
                                    imageFile1 = File(image1!.path);
                                    _controller = VideoPlayerController.file(imageFile1!)
                                      ..initialize().then((value) => setState(() {
                                            _controller?.play();
                                          }));
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(color: Colors.white70),
                                    child: const Icon(Icons.camera_alt, size: 40, color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Video",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  image1 = await _picker.pickVideo(source: ImageSource.gallery);

                                  if (image1 != null) {
                                    imageFile1 = File(image1!.path);
                                    _controller = VideoPlayerController.file(imageFile1!)
                                      ..initialize().then((value) => setState(() {
                                            _controller?.play();
                                          }));
                                  }

                                  Navigator.of(context).pop();
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(color: Colors.white70),
                                    child: const Icon(Icons.filter_rounded, size: 40, color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Gallery Video",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Text("Video Picker", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
