import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/category_design_list_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart'
    as design_cate_item;
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/inc_dec_qty_for_listing_widget.dart';

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
                  flex: 6,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(
                          AppRoutes.categoryDesignDetailsScreen,
                          arguments: {
                            RouteConstants.designDetailsModel:
                                cateDesignListItem,
                            RouteConstants.goldKarat: goldKarat,
                          },
                        ),
                        highlightColor: Colors.transparent,
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: cateDesignListItem.designImage,
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SpinKitSpinningLines(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Padding(
                              padding: EdgeInsets.only(top: 70),
                              child: Icon(
                                Icons.error,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => Get.toNamed(
                            AppRoutes.zoomableImageViewScreen,
                            arguments: {
                              RouteConstants.title:
                                  cateDesignListItem.designName,
                              RouteConstants.imageUrl:
                                  cateDesignListItem.designImage
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
                  flex: 4,
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
                                      AppRoutes.categoryDesignDetailsScreen,
                                      arguments: {
                                        RouteConstants.designDetailsModel:
                                            cateDesignListItem,
                                        RouteConstants.goldKarat: goldKarat,
                                      },
                                    )!
                                        .then((result) {
                                      if (result != null && result) {
                                        return;
                                      }
                                      categoryDesignListController
                                          .getCategoryDesignListApiCall(
                                        goldCaret: goldKarat,
                                        subCategoryId: subCategoryId,
                                      );
                                      return;
                                    }),
                                    highlightColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text(
                                      cateDesignListItem.designName,
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
                                      AppRoutes.categoryDesignDetailsScreen,
                                      arguments: {
                                        RouteConstants.designDetailsModel:
                                            cateDesignListItem,
                                        RouteConstants.goldKarat: goldKarat,
                                      },
                                    )!
                                        .then((result) {
                                      if (result != null && result) {
                                        return;
                                      }
                                      categoryDesignListController
                                          .getCategoryDesignListApiCall(
                                        goldCaret: goldKarat,
                                        subCategoryId: subCategoryId,
                                      );
                                      return;
                                    }),
                                    highlightColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text(
                                      '(${cateDesignListItem.designWeight})',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            Get.textTheme.titleSmall!.fontSize,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => cateDesignListItem.userCartQty.value == 0
                                  ? ElevatedButton.icon(
                                      onPressed: () {
                                        cartController
                                            .addToCartForDesignListApiCall(
                                          context: context,
                                          designId: cateDesignListItem.designId
                                              .toString(),
                                          goldKarat: goldKarat,
                                          designQty: 1,
                                        )
                                            .then((result) {
                                          if (result != null) {
                                            cateDesignListItem
                                                .userCartQty.value = 1;
                                            cateDesignListItem.setUserCartId =
                                                result;
                                            return;
                                          }
                                          return;
                                        }).catchError((_) {
                                          cateDesignListItem.userCartQty.value =
                                              0;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                        ),
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 22,
                                      ),
                                      label: Text(
                                        'add_to_cart'.tr,
                                      ),
                                    )
                                  : IncDecQtyForListingWidget(
                                      categoryDesignListController:
                                          categoryDesignListController,
                                      cateDesignListItem: cateDesignListItem,
                                      cartController: cartController,
                                      goldKarat: goldKarat,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(
                          () => cateDesignListItem.isLoading.value
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
