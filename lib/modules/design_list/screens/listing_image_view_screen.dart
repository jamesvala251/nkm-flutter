import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';

class ListingImageViewScreen extends StatefulWidget {
  const ListingImageViewScreen({super.key});

  @override
  State<ListingImageViewScreen> createState() => _ListingImageViewScreenState();
}

class _ListingImageViewScreenState extends State<ListingImageViewScreen> {
  late String title;
  late List<String> imageUrlList;

  final RxInt currentIndex = 0.obs;
  final ScrollController _scrollController = ScrollController();
  final RxDouble _scrollPosition = 0.0.obs;

  @override
  void initState() {
    Map<String, dynamic> temp = Get.arguments as Map<String, dynamic>;
    title = temp[RouteConstants.title] as String;
    imageUrlList = temp[RouteConstants.imageUrl] as List<String>;

    _scrollController.addListener(() {
      setState(() {
        _scrollPosition.value = _scrollController.offset;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: imageUrlList.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: InteractiveViewer(
                        maxScale: 5,
                        minScale: 1,
                        child: CachedNetworkImage(
                          imageUrl: imageUrlList[index],
                          fit: BoxFit.contain,
                          width: Get.width,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => const Center(
                            child: SpinKitSpinningLines(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Icon(Icons.error,
                                size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
              Obx(
                () => currentIndex.value >= 1
                    ? Positioned(
                        left: 16,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_left_rounded,
                            color: Get.theme.primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              if (currentIndex > 0) {
                                currentIndex.value--;
                                _scrollController.animateTo(
                                  _scrollPosition.value - Get.width,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                );
                              }
                            } catch (_) {}
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => imageUrlList.length - 1 > currentIndex.value
                    ? Positioned(
                        right: 16,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Get.theme.primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              if (currentIndex < imageUrlList.length - 1) {
                                currentIndex.value++;
                                _scrollController.animateTo(
                                  _scrollPosition.value + Get.width,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                );
                              }
                            } catch (_) {}
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
