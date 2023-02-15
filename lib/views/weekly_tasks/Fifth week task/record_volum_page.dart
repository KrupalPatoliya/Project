import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../helpers/database_helpper/record_db_helpper.dart';

class RecorderPage extends StatefulWidget {
  const RecorderPage({Key? key}) : super(key: key);

  @override
  State<RecorderPage> createState() => _RecorderPageState();
}

String? path;

class _RecorderPageState extends State<RecorderPage> {
  RecorderController recorderController = RecorderController();
  PlayerController playerController = PlayerController();
  String? path;

  late Directory directory;

  int duration = 0;

  @override
  void initState() {
    // TODO: implement initState
    playerController.addListener(() async {
      duration = await playerController.getDuration();
      setState(() {});
    });
    super.initState();
    recorderController = RecorderController();
    playerController = PlayerController();

    recorderController.addListener(() {
      duration = recorderController.updateFrequency.inSeconds;
      print(duration);
      setState(() {});
    });
  }

  @override
  void deactivate() {
    recorderController.dispose();
    playerController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Recorder Page"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AudioWaveforms(
              waveStyle: const WaveStyle(
                waveColor: Colors.white,
              ),
              size: Size(MediaQuery.of(context).size.width, 60),
              recorderController: recorderController,
            ),
            const SizedBox(
              height: 80,
            ),
            // Text(
            //   duration.toString(),
            //   style: TextStyle(color: Colors.white),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      String? p = await recorderController.stop();

                      var string = p?.split("/").last.toString();

                      directory = (await getTemporaryDirectory());

                      path = "${directory.path}/$string";
                      RecordDataBaseHelpper.dataBaseHelpper.insertData(name: path!);

                      await playerController.preparePlayer(path: p!,);

                      setState(() {});
                    },
                    icon: Icon(CupertinoIcons.stop_fill, color: Colors.white)),
                InkWell(
                  onTap: () async {
                    await recorderController.record();
                    await playerController.pausePlayer();
                    setState(() {});
                  },
                  child: const Icon(CupertinoIcons.mic_fill, color: Colors.white),
                ),
                InkWell(
                  onTap: () async {
                    await recorderController.pause();
                    setState(() {});
                  },
                  child: const Icon(CupertinoIcons.pause, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
