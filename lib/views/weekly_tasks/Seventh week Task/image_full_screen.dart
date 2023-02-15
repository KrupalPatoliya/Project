import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:training_app/models/music.dart';
import 'package:video_player/video_player.dart';

class ImageFullScreen extends StatefulWidget {
  ImageFullScreen({Key? key, required this.image, required this.index}) : super(key: key);

  List<ImageFile> image;
  int index;

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  VideoPlayerController? _controller;

  int i = 0;

  initController() {
    if (widget.image[i].name.split(".")[1] == "mp4") {
      _controller = VideoPlayerController.file(File(widget.image[i].files.path))
        ..initialize().then(
          (value) => setState(
            () {
              _controller?.play();
            },
          ),
        );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    i = widget.index;
    initController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.image[i].name),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: (widget.image[i].name.split(".")[1] == "mp4")
                  ? SizedBox(
                      width: 400,
                      height: 600,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(
                              _controller!,
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
                      ),
                    )
                  : SizedBox(
                      width: 400,
                      height: 600,
                      child: PhotoView(
                        maxScale: 1.00,
                        minScale: 0.1,
                        imageProvider: FileImage(widget.image[i].files),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (i == 0) {
                        i = widget.image.length;
                        i--;
                        initController();
                      } else {
                        i--;
                        initController();
                      }
                    });
                  },
                  child: const Icon(Icons.navigate_before),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (widget.image.length == i) {
                        i = 1;
                        i++;
                        initController();
                      } else {
                        i++;
                        initController();
                      }
                    });
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
