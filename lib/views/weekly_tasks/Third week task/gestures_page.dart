import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:training_app/utils/global_list.dart';

class GesturesPage extends StatefulWidget {
  const GesturesPage({Key? key}) : super(key: key);

  @override
  State<GesturesPage> createState() => _GesturesPageState();
}

class _GesturesPageState extends State<GesturesPage> {
  double min = pi * -2;
  double max = pi * 2;

  double minScale = 0.3;
  double defScale = 0.1;
  double maxScale = 4;

  late PhotoViewControllerBase controller;
  late PhotoViewScaleStateController scaleStateController;
  int calls = 0;

  void onController(PhotoViewControllerValue value) {
    setState(() {
      calls += 1;
    });
  }

  void onScaleState(PhotoViewScaleState scaleState) {
    print(scaleState);
  }

  Axis direction = Axis.horizontal;

  @override
  void initState() {
    // TODO: implement initState
    controller = PhotoViewController(initialScale: defScale)..outputStateStream.listen(onController);

    scaleStateController = PhotoViewScaleStateController()..outputScaleStateStream.listen(onScaleState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Gestures"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: GestureDetector(
          dragStartBehavior: DragStartBehavior.start,
          onVerticalDragStart: (val) {
            setState(() {
              direction = Axis.vertical;
            });
          },
          onHorizontalDragStart: (val) {
            setState(() {
              direction = Axis.horizontal;
            });
          },
          child: PhotoViewGallery.builder(
            reverse: false,
            enableRotation: true,
            scrollPhysics: const BouncingScrollPhysics(),
            scrollDirection: direction,
            itemCount: items.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                maxScale: maxScale,
                minScale: minScale,
                scaleStateController: scaleStateController,
                imageProvider: AssetImage(items[index].resource),
                heroAttributes: PhotoViewHeroAttributes(tag: items[index].id),
              );
            },
          ),
        ),
      ),
    );
  }
}
