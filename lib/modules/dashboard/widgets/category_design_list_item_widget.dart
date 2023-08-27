import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/shimmer_lib/shimmer.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_category_model.dart'
    as design_cate_item;

class CategoryDesignListItemWidget extends StatelessWidget {
  final DashboardController dashboardController;
  final design_cate_item.Data designCategoryItemModel;

  const CategoryDesignListItemWidget({
    Key? key,
    required this.dashboardController,
    required this.designCategoryItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Get.theme.primaryColor,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.subCategoryDesignScreen,
            arguments: {
              RouteConstants.categoryName: designCategoryItemModel.categoryName,
              RouteConstants.goldKarat:
                  dashboardController.selectedKarat.value.toString(),
              RouteConstants.categoryId:
                  designCategoryItemModel.categoryId.toString(),
            },
          )?.then((value) {
            dashboardController.getGoldRatesApiCall();
          });
        },
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 222,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                ImagesPath.productBackground,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  ImagesPath.appIcon,
                  alignment: Alignment.topCenter,
                  height: 44,
                  width: 44,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: designCategoryItemModel.categoryImage,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: SpinKitSpinningLines(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 6,
                  ),
                  child: Shimmer(
                    enabled: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow[100]!,
                        Colors.amber[300]!,
                        Colors.yellow[100]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.clamp,
                    ),
                    child: Text(
                      designCategoryItemModel.categoryName,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: const Color(0xFFFFE998),
                          fontSize: Get.textTheme.titleLarge!.fontSize),
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
