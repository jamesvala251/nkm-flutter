import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/sub_category_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_sub_category_model.dart'
    as designSubCateItem;

class SubCategoryDesignListItemWidget extends StatelessWidget {
  final SubCategoryController subCategoryController;
  final designSubCateItem.Data subCateItem;
  final String goldKarat;

  const SubCategoryDesignListItemWidget({
    Key? key,
    required this.subCategoryController,
    required this.subCateItem,
    required this.goldKarat,
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
          );
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
                      const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 48),
                      child: CircularProgressIndicator(),
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
