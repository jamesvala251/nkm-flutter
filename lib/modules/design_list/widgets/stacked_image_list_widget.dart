import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/models/design_list_model.dart'
    as design_cate_item;

class StackedImageListWidget extends StatelessWidget {
  final design_cate_item.Data cateDesignListItem;
  final String goldKarat;

  const StackedImageListWidget({
    super.key,
    required this.cateDesignListItem,
    required this.goldKarat,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (cateDesignListItem.images.isNotEmpty) {
          return cateDesignListItem.images.length > 1
              ? _getForMultipleImages(constraints: constraints)
              : _getForSingleImage(constraints: constraints);
        }
        return const SizedBox.shrink();
      },
    );
  }

  IntrinsicHeight _getForMultipleImages({required BoxConstraints constraints}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (cateDesignListItem.videos.isNotEmpty) ...[
            Container(
              height: constraints.maxWidth * 0.30,
              width: constraints.maxWidth * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 1.2,
                  color: Get.theme.primaryColor,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.videoViewScreen,
                    arguments: {
                      RouteConstants.productListItemModel: cateDesignListItem,
                      RouteConstants.goldKarat: goldKarat,
                    },
                  );
                },
                borderRadius: BorderRadius.circular(60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: CachedNetworkImage(
                          imageUrl: cateDesignListItem.images.first,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: SpinKitSpinningLines(
                              color: Get.theme.primaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            ImagesPath.noImageAvailable,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.05,
            ),
            Container(
              width: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Colors.transparent
                  ],
                  stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          SizedBox(
            height: constraints.maxWidth * 0.30,
            width: constraints.maxWidth * 0.60,
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.listingImageViewScreen,
                  arguments: {
                    RouteConstants.title: cateDesignListItem.name,
                    RouteConstants.imageUrl: cateDesignListItem.images,
                  },
                );
              },
              child: Stack(
                children: [
                  Positioned(
                    left: constraints.maxWidth * 0.05,
                    child: Container(
                      height: constraints.maxWidth * 0.30,
                      width: constraints.maxWidth * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          width: 1.2,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Transform.scale(
                          scale: 1.8,
                          child: CachedNetworkImage(
                            imageUrl: cateDesignListItem.images.first,
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SpinKitSpinningLines(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              ImagesPath.noImageAvailable,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth * 0.30,
                    child: Container(
                      height: constraints.maxWidth * 0.30,
                      width: constraints.maxWidth * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          width: 1.2,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Transform.scale(
                          scale: 1.8,
                          child: CachedNetworkImage(
                            imageUrl: cateDesignListItem.images[1],
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SpinKitSpinningLines(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              ImagesPath.noImageAvailable,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IntrinsicHeight _getForSingleImage({
    required BoxConstraints constraints,
  }) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (cateDesignListItem.videos.isNotEmpty) ...[
            Container(
              height: constraints.maxWidth * 0.30,
              width: constraints.maxWidth * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 1.2,
                  color: Get.theme.primaryColor,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.videoViewScreen,
                    arguments: {
                      RouteConstants.productListItemModel: cateDesignListItem,
                      RouteConstants.goldKarat: goldKarat,
                    },
                  );
                },
                borderRadius: BorderRadius.circular(60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: CachedNetworkImage(
                          imageUrl: cateDesignListItem.images.first,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: SpinKitSpinningLines(
                              color: Get.theme.primaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            ImagesPath.noImageAvailable,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Get.theme.primaryColor,
                    Colors.transparent
                  ],
                  stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          Container(
            height: constraints.maxWidth * 0.30,
            width: constraints.maxWidth * 0.30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                width: 1.2,
                color: Get.theme.primaryColor,
              ),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.listingImageViewScreen,
                  arguments: {
                    RouteConstants.title: cateDesignListItem.name,
                    RouteConstants.imageUrl: cateDesignListItem.images,
                  },
                );
              },
              borderRadius: BorderRadius.circular(60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Transform.scale(
                  scale: 1.8,
                  child: CachedNetworkImage(
                    imageUrl: cateDesignListItem.images.first,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: SpinKitSpinningLines(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      ImagesPath.noImageAvailable,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
