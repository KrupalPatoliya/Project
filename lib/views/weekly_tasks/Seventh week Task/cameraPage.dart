import 'dart:io';

import 'package:camera/camera.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/show_image_video.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../main.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with TickerProviderStateMixin {
  String dropDownValue = 'Auto';

  var items = ['Auto', 'On', 'Off', 'Touch'];

  int selectedCamera = 0;
  bool isFront = false;
  bool isFocus = false;
  bool onTapForVideo = false;
  double _value = 1;
  bool isVideo = false;
  bool isImage = false;
  final CustomTimerController customTimerController = CustomTimerController();
  Uint8List? thumb;
  File? takePic;
  XFile? file;

  late CameraController controller = CameraController(cameras[0], ResolutionPreset.high);

  @override
  void initState() {
    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller.setFlashMode(FlashMode.auto);
    controller.initialize().then((value) => setState(() {}));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Camera",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: (controller.value.isInitialized)
          ? Stack(
              children: [
                CameraPreview(controller),
                Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.black26,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (isFront == false) {
                                setState(() {
                                  controller = CameraController(cameras[1], ResolutionPreset.high);
                                  controller.initialize().then((value) => setState(() {}));
                                });
                                isFront = true;
                              } else {
                                setState(() {
                                  controller = CameraController(cameras[0], ResolutionPreset.high);
                                  controller.initialize().then((value) => setState(() {}));
                                });
                                isFront = false;
                              }
                            },
                            icon: Icon((isFront == true) ? CupertinoIcons.camera_rotate_fill : CupertinoIcons.camera_rotate,
                                color: Colors.white, size: 25),
                          ),
                          DropdownButton(
                            underline: const SizedBox(),
                            iconSize: 0.0,
                            dropdownColor: Colors.black26,
                            focusColor: Colors.white,
                            items: items.map(
                              (String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items, style: const TextStyle(color: Colors.white, fontSize: 18)),
                                );
                              },
                            ).toList(),
                            value: dropDownValue,
                            enableFeedback: true,
                            onChanged: (val) {
                              setState(() {
                                dropDownValue = val!;
                                if (val == 'Auto') {
                                  setState(() {
                                    controller.setFlashMode(FlashMode.auto).then((value) => setState(() {}));
                                    // controller = CameraController(cameras[0], ResolutionPreset.high);
                                  });
                                } else if (val == 'Off') {
                                  setState(() {
                                    controller.setFlashMode(FlashMode.off).then((value) => setState(() {}));
                                    // controller = CameraController(cameras[0], ResolutionPreset.high);
                                  });
                                } else if (val == 'On') {
                                  setState(() {
                                    controller.setFlashMode(FlashMode.always).then((value) => setState(() {}));
                                    // controller = CameraController(cameras[0], ResolutionPreset.high);
                                  });
                                } else {
                                  setState(() {
                                    controller.setFlashMode(FlashMode.torch).then((value) => setState(() {}));
                                    // controller = CameraController(cameras[0], ResolutionPreset.high);
                                  });
                                }
                              });
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              if (isFocus) {
                                setState(() {
                                  controller.setFocusMode(FocusMode.auto).then((value) => setState(() {}));
                                  // controller = CameraController(cameras[1], ResolutionPreset.high);
                                });
                                isFocus = false;
                              } else {
                                setState(() {
                                  controller.setFocusMode(FocusMode.locked).then((value) => setState(() {}));
                                  // controller = CameraController(cameras[0], ResolutionPreset.high);
                                });
                                isFocus = true;
                              }
                            },
                            icon: Icon(Icons.center_focus_strong_outlined, color: (isFocus) ? Colors.white : Colors.amber, size: 25),
                          ),
                        ],
                      ),
                    ),
                    (isVideo == true)
                        ? CustomTimer(
                            controller: customTimerController,
                            begin: const Duration(),
                            end: const Duration(days: 1),
                            builder: (time) {
                              return Text("${time.hours}:${time.minutes}:${time.seconds}",
                                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white));
                            })
                        : const SizedBox(),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          color: Colors.black45,
                          width: 300,
                          child: Slider(
                            min: 1,
                            max: 5,
                            value: _value,
                            inactiveColor: Colors.white24,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _value = value;

                                controller.setZoomLevel(value);
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Text(
                            double.parse(_value.toStringAsFixed(2)).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 70,
                      color: Colors.black26,
                      child: (onTapForVideo)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (controller.value.isRecordingPaused) {
                                      await controller.resumeVideoRecording();
                                      customTimerController.start();
                                      setState(() {});
                                    } else {
                                      await controller.pauseVideoRecording();
                                      customTimerController.pause();
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon((controller.value.isRecordingPaused) ? Icons.pause : Icons.restart_alt, color: Colors.white, size: 25),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    file = await controller.stopVideoRecording();

                                    thumb = await VideoThumbnail.thumbnailData(
                                      video: file!.path,
                                      maxWidth: 128,
                                      quality: 25,
                                    );

                                    GallerySaver.saveVideo(file!.path).then((value) => setState(() {
                                          print("Saved Image");
                                        }));

                                    setState(() {
                                      isImage = false;
                                      // takePic = File.fromRawPath(f!);
                                      onTapForVideo = false;
                                      isVideo = false;
                                      customTimerController.finish();
                                      customTimerController.reset();
                                    });
                                  },
                                  icon: const Icon(Icons.stop, color: Colors.white, size: 25),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await controller.startVideoRecording();
                                    setState(() {
                                      onTapForVideo = true;
                                      isVideo = true;
                                      customTimerController.start();
                                    });
                                  },
                                  icon: const Icon(Icons.videocam, color: Colors.white, size: 25),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    // controller.pausePreview();
                                    //
                                    // controller.lockCaptureOrientation();

                                    file = await controller.takePicture();
                                    GallerySaver.saveImage(file!.path).then((value) => setState(() {
                                          print("Saved Image");
                                        }));
                                    setState(() {
                                      takePic = File(file!.path);
                                      isImage = true;
                                      // controller.resumePreview().then((value) => setState(() {}));
                                    });
                                    print(file!.path);
                                  },
                                  icon: const Icon(Icons.camera, color: Colors.white, size: 25),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (file != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ShowImageAndVideoPage(
                                            file: file!,
                                            isImage: isImage,
                                          ),
                                        ),
                                      );
                                    } else {}
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 3, color: Colors.grey),
                                    ),
                                    child: (isImage)
                                        ? (takePic == null)
                                            ? const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28)
                                            : Image(
                                                image: FileImage(takePic!),
                                              )
                                        : (thumb == null)
                                            ? const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28)
                                            : Image(
                                                image: MemoryImage(thumb!),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            )
          : Container(),
    );
  }
}
