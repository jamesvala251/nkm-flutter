import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({Key? key}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late VideoPlayerController videoPlayerController;
  Rx<Duration> currentVideoPosition = const Duration(seconds: 0).obs;
  late String title;
  late String videoUrl;
  final RxBool _isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    Map<String, String> temp = Get.arguments as Map<String, String>;
    title = temp[RouteConstants.title] as String;
    videoUrl = temp[RouteConstants.videoUrl] as String;
    print('Video URL: $videoUrl');

    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        _isLoading.value = false;
      })
      ..play();
    videoPlayerController.addListener(() {
      currentVideoPosition.value = videoPlayerController.value.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(title),
      ),
      body: Obx(
        () => _isLoading.value
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white,),
              const SizedBox(
                height: 16,
              ),
              Text(
                "loading".tr,
                style: const TextStyle(
                  letterSpacing: 1.1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: videoPlayerController.value.isInitialized
                    ? Center(child: videoPlayerWidget())
                    : const SizedBox(),
              ),
      ),
    );
  }

  Widget videoPlayerWidget() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    videoPlayerController.value.isPlaying
                        ? videoPlayerController.pause()
                        : videoPlayerController.play();
                  });
                },
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                ),
              ),
            ),
            videoProgressIndicatorWidget()
          ],
        ),
        AnimatedOpacity(
            opacity: videoPlayerController.value.isPlaying ? 0 : 1,
            duration: const Duration(seconds: 1),
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.black54,
              child: videoPlayerController.value.isPlaying
                  ? const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 44,
                    )
                  : const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
            )),
      ],
    );
  }

  Widget videoProgressIndicatorWidget() {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          VideoProgressIndicator(
            videoPlayerController,
            allowScrubbing: true,
            colors: const VideoProgressColors(
                backgroundColor: Colors.white, playedColor: Colors.purple),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  '${currentVideoPosition.value.inMinutes}:${currentVideoPosition.value.inSeconds}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Text(
                  '${videoPlayerController.value.duration.inMinutes}:${videoPlayerController.value.duration.inSeconds}',
                  style: const TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  void pauseVideo() {
    setState(() {
      videoPlayerController.pause();
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
