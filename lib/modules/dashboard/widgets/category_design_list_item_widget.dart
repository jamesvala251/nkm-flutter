import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/shimmer_lib/shimmer.dart';
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
      // semanticContainer: true,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
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
              RouteConstants.goldKarat: dashboardController.selectedKarat.value,
              RouteConstants.categoryId:
                  designCategoryItemModel.categoryId.toString(),
            },
          );
        },
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Get.theme.primaryColor,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      ImagesPath.productBackground,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 200,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 4.0,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          ImagesPath.appIcon,
                          height: 44,
                          width: 44,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        color: Colors.white,
                        width: Get.width * 0.47,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CachedNetworkImage(
                            imageUrl: designCategoryItemModel.categoryImage,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
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
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8,
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
                                // maxLines: 2,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style:  TextStyle(
                                  color: const Color(0xFFFFE998),
                                  fontSize: Get.textTheme.titleLarge!.fontSize
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
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Card(
//     elevation: 4,
//     margin: const EdgeInsets.all(12),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: InkWell(
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.subCategoryDesignScreen,
//           arguments: {
//             RouteConstants.categoryName: designCategoryItemModel.categoryName,
//             RouteConstants.goldKarat: dashboardController.selectedKarat.value,
//             RouteConstants.categoryId:
//                 designCategoryItemModel.categoryId.toString(),
//           },
//         );
//       },
//       highlightColor: Colors.transparent,
//       borderRadius: BorderRadius.circular(12),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CachedNetworkImage(
//                 imageUrl: designCategoryItemModel.categoryImage,
//                 fit: BoxFit.contain,
//                 progressIndicatorBuilder: (context, url, downloadProgress) =>
//                     const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 48),
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => const Padding(
//                   padding: EdgeInsets.only(top: 70),
//                   child: Icon(
//                     Icons.error,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 8.0,
//                   horizontal: 8,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.black45,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(12),
//                       bottomRight: Radius.circular(12)),
//                 ),
//                 child: Text(
//                   designCategoryItemModel.categoryName,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
