import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/dimens.dart';

class VideossWidget extends StatefulWidget {
  final id;
  VideossWidget({Key? key, this.id}) : super(key: key);

  @override
  _VideossWidgetState createState() => _VideossWidgetState();
}

class _VideossWidgetState extends State<VideossWidget> {
  YoutubePlayerController? videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    controller = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: const YoutubePlayerFlags(
          forceHD: true,
          autoPlay: false,
          mute: false,
          loop: false,
        ));
  } // This closing tag was missing

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    videoPlayerController!.dispose();
    controller!.dispose(); //    widget.videoPlayerController.dispose();
    super.dispose();
  }

  // Future<bool> started() async {
  //   await videoPlayerController!.initialize();
  //   await videoPlayerController!.play();
  //   startedPlaying = true;
  //   return true;
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          STM().back2Previous(context);
          return false;
        },
        child: Scaffold(
            backgroundColor: Clr().black,
            // appBar: MediaQuery.of(context).orientation == Orientation.landscape
            //     ? null
            //     : AppBar(
            //         backgroundColor: Clr().black,
            //         leading: IconButton(
            //             onPressed: () {
            //               STM().back2Previous(context);
            //             },
            //             icon: Icon(
            //               Icons.arrow_back,
            //               color: Clr().white,
            //             )),
            //       ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: YoutubePlayer(
                controller: controller!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Clr().primaryColor,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                        backgroundColor: Clr().grey,
                        bufferedColor: Clr().white,
                        handleColor: Clr().red,
                        playedColor: Clr().red),
                  ),
                  RemainingDuration(),
                  PlaybackSpeedButton(),
                  SizedBox(width: Dim().d12),
                  InkWell(
                      onTap: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeRight,
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        STM().back2Previous(context);
                      },
                      child: Icon(Icons.fullscreen_exit, color: Clr().white))
                ],
              ),
            )));
  }
}
