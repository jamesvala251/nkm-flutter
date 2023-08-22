import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/controllers/sub_category_controller.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/models/design_sub_category_model.dart'
    as design_sub_cate_item;

class SubCategoryDesignListItemWidget extends StatelessWidget {
  final SubCategoryController subCategoryController;
  final design_sub_cate_item.Data subCateItem;
  final String goldKarat;
  final String categoryId;

  const SubCategoryDesignListItemWidget({
    Key? key,
    required this.subCategoryController,
    required this.subCateItem,
    required this.goldKarat,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.categoryDesignListScreen,
            arguments: {
              RouteConstants.subCategoryName: subCateItem.subCategoryName,
              RouteConstants.goldKarat: goldKarat,
              RouteConstants.subCategoryId:
                  subCateItem.subCategoryId.toString(),
            },
          )?.then((value) {
            subCategoryController.refreshSubCategoryApiCall(
              goldCaret: goldKarat,
              categoryId: categoryId,
            );
          });
        },
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CachedNetworkImage(
                  imageUrl: subCateItem.subCategoryImage,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: SpinKitSpinningLines(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Icon(
                      Icons.error_rounded,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    subCateItem.subCategoryName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
