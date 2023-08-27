import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/controllers/category_design_list_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/models/design_list_model.dart'
    as design_cate_item;
import 'package:nkm_nose_pins_llp/modules/design_list/widgets/stacked_image_list_widget.dart';

class CategoryDesignListItem extends StatelessWidget {
  final CategoryDesignListController categoryDesignListController;
  final CartController cartController;
  final design_cate_item.Data cateDesignListItem;
  final String goldKarat;
  final String subCategoryId;

  const CategoryDesignListItem({
    Key? key,
    required this.categoryDesignListController,
    required this.cartController,
    required this.cateDesignListItem,
    required this.goldKarat,
    required this.subCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      cateDesignListItem.images.isNotEmpty
                          ? InkWell(
                              onTap: () => Get.toNamed(
                                AppRoutes.designArticleScreen,
                                arguments: {
                                  RouteConstants.designId:
                                      cateDesignListItem.id,
                                  RouteConstants.designName:
                                      cateDesignListItem.name,
                                  RouteConstants.goldKarat: goldKarat,
                                },
                              )?.then((result) {
                                categoryDesignListController
                                    .refreshSubCategoryDesignList(
                                  goldCaret: goldKarat,
                                  subCategoryId: subCategoryId,
                                );
                              }),
                              highlightColor: Colors.transparent,
                              child: Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: CachedNetworkImage(
                                    imageUrl: cateDesignListItem.images.first,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.centerLeft,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: SpinKitSpinningLines(
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Padding(
                                      padding: EdgeInsets.only(top: 70),
                                      child: Icon(
                                        Icons.error_rounded,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                ImagesPath.noImageAvailable,
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => Get.toNamed(
                            AppRoutes.zoomableImageViewScreen,
                            arguments: {
                              RouteConstants.title: cateDesignListItem.name,
                              RouteConstants.imageUrl:
                                  cateDesignListItem.images.first
                            },
                          ),
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            Icons.zoom_in_rounded,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 0.8,
                  color: Colors.grey,
                  indent: 8,
                  endIndent: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                      AppRoutes.designArticleScreen,
                                      arguments: {
                                        RouteConstants.designId:
                                            cateDesignListItem.id,
                                        RouteConstants.designName:
                                            cateDesignListItem.name,
                                        RouteConstants.goldKarat: goldKarat,
                                      },
                                    )?.then((result) {
                                      categoryDesignListController
                                          .refreshSubCategoryDesignList(
                                        goldCaret: goldKarat,
                                        subCategoryId: subCategoryId,
                                      );
                                    }),
                                    highlightColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text(
                                      cateDesignListItem.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            Get.textTheme.titleMedium!.fontSize,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                      AppRoutes.designArticleScreen,
                                      arguments: {
                                        RouteConstants.designId:
                                            cateDesignListItem.id,
                                        RouteConstants.designName:
                                            cateDesignListItem.name,
                                        RouteConstants.goldKarat: goldKarat,
                                      },
                                    )?.then((result) {
                                      categoryDesignListController
                                          .refreshSubCategoryDesignList(
                                        goldCaret: goldKarat,
                                        subCategoryId: subCategoryId,
                                      );
                                    }),
                                    highlightColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Obx(
                                      () => Text(
                                        '${cateDesignListItem.articleCount.value} Article',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: Get
                                              .textTheme.titleMedium!.fontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StackedImageListWidget(
                              cateDesignListItem: cateDesignListItem,
                              goldKarat: goldKarat,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(
                          () => cateDesignListItem.isLoadingImage.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SpinKitSpinningLines(
                                    color: Get.theme.primaryColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    cateDesignListItem.shareImage(
                                      goldKarat: goldKarat,
                                      imageIndex: 0,
                                    );
                                  },
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
