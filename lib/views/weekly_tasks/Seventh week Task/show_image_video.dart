import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ShowImageAndVideoPage extends StatefulWidget {
  ShowImageAndVideoPage({Key? key, required this.isImage, required this.file}) : super(key: key);

  bool isImage;
  XFile? file;

  @override
  State<ShowImageAndVideoPage> createState() => _ShowImageAndVideoPageState();
}

class _ShowImageAndVideoPageState extends State<ShowImageAndVideoPage> {
  VideoPlayerController? _controller;

  bool isPlay = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.file == null) {
    } else {
      _controller = VideoPlayerController.file(File(widget.file!.path))
        ..initialize().then((value) => setState(() {
              _controller?.play();
            }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Show Image And Video",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.isImage)
                ? Container(
                    height: 400,
                    width: 400,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      // borderRadius: BorderRadius.circular(20),
                      // border: Border.all(width: 3, color: Colors.grey),
                    ),
                    child: (widget.file != null) ? Image.file(File(widget.file!.path), fit: BoxFit.cover) : Text("Image Not Found"),
                  )
                : (widget.file == null)
                    ? Center(
                        child: Text("Image Not Found"),
                      )
                    : Stack(
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
                      ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
