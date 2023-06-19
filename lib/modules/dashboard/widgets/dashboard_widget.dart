import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/category_design_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class DashboardWidget extends StatelessWidget {
  final DashboardController dashboardController;

  const DashboardWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getDesignCategorySelectionWidget,
        Expanded(
          child: Obx(
            () => dashboardController.isLoadingDesignCategory.value
                ? const LoadingWidget()
                : dashboardController
                        .errorStringWhileLoadingDesignCategory.isEmpty
                    ? dashboardController.designCategoryModel!.data.isNotEmpty
                        ? _getCategoryListWidget
                        : NoDataFoundWidget(
                            retryOn: () =>
                                dashboardController.getDesignCategoryApiCall(
                              goldCaret:
                                  dashboardController.selectedKarat.value,
                            ),
                          )
                    : SomethingWentWrongWidget(
                        errorTxt: dashboardController
                            .errorStringWhileLoadingDesignCategory.value,
                        retryOnSomethingWentWrong: () =>
                            dashboardController.getDesignCategoryApiCall(
                          goldCaret: dashboardController.selectedKarat.value,
                        ),
                      ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView get _getDesignCategorySelectionWidget =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Obx(
              () => Card(
                margin: const EdgeInsets.only(
                  left: 12,
                  top: 8,
                  right: 8,
                  bottom: 8,
                ),
                color: dashboardController.selectedKarat.value == '14'
                    ? Get.theme.primaryColor
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    color: Color(0xFFFFE998),
                  ),
                ),
                child: InkWell(
                  onTap: dashboardController.isLoadingDesignCategory.value
                      ? null
                      : () => dashboardController.getDesignCategoryApiCall(
                            goldCaret: '14',
                          ),
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    child: Text(
                      '14 Karat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: dashboardController.selectedKarat.value == '14'
                            ? const Color(0xFFFFE998)
                            : Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Card(
                margin: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 8,
                  bottom: 8,
                ),
                color: dashboardController.selectedKarat.value == '18'
                    ? Get.theme.primaryColor
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    color: Color(0xFFFFE998),
                  ),
                ),
                child: InkWell(
                  onTap: dashboardController.isLoadingDesignCategory.value
                      ? null
                      : () => dashboardController.getDesignCategoryApiCall(
                            goldCaret: '18',
                          ),
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    child: Text(
                      '18 Karat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: dashboardController.selectedKarat.value == '18'
                            ? const Color(0xFFFFE998)
                            : Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Obx(
            //   () => Card(
            //     margin: const EdgeInsets.only(
            //       left: 8,
            //       top: 8,
            //       right: 8,
            //       bottom: 8,
            //     ),
            //     color: dashboardController.selectedKarat.value == '20'
            //         ? Get.theme.primaryColor
            //         : Colors.white,
            //     elevation: 4,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //       side: const BorderSide(
            //         color: Color(0xFFFFE998),
            //       ),
            //     ),
            //     child: InkWell(
            //       onTap: dashboardController.isLoadingDesignCategory.value
            //           ? null
            //           : () => dashboardController.getDesignCategoryApiCall(
            //                 goldCaret: '20',
            //               ),
            //       highlightColor: Colors.transparent,
            //       borderRadius: BorderRadius.circular(8.0),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 8,
            //           horizontal: 18,
            //         ),
            //         child: Text(
            //           '20 Karat',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: dashboardController.selectedKarat.value == '20'
            //                 ?   const Color(0xFFFFE998)
            //
            //                 : Get.theme.primaryColor,
            //             fontSize: Get.textTheme.titleMedium!.fontSize,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Obx(
            //   () => Card(
            //     margin: const EdgeInsets.only(
            //       left: 8,
            //       top: 8,
            //       right: 8,
            //       bottom: 8,
            //     ),
            //     color: dashboardController.selectedKarat.value == '22'
            //         ? Get.theme.primaryColor
            //         : Colors.white,
            //     elevation: 4,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //       side: const BorderSide(
            //         color: Color(0xFFFFE998),
            //       ),
            //     ),
            //     child: InkWell(
            //       onTap: dashboardController.isLoadingDesignCategory.value
            //           ? null
            //           : () => dashboardController.getDesignCategoryApiCall(
            //                 goldCaret: '22',
            //               ),
            //       highlightColor: Colors.transparent,
            //       borderRadius: BorderRadius.circular(8.0),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 8,
            //           horizontal: 18,
            //         ),
            //         child: Text(
            //           '22 Karat',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: dashboardController.selectedKarat.value == '22'
            //                 ?    const Color(0xFFFFE998)
            //                 : Get.theme.primaryColor,
            //             fontSize: Get.textTheme.titleMedium!.fontSize,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Obx(
              () => Card(
                margin: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 12,
                  bottom: 8,
                ),
                color: dashboardController.selectedKarat.value == '24'
                    ? Get.theme.primaryColor
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    color: Color(0xFFFFE998),
                  ),
                ),
                child: InkWell(
                  onTap: dashboardController.isLoadingDesignCategory.value
                      ? null
                      : () => dashboardController.getDesignCategoryApiCall(
                            goldCaret: '24',
                          ),
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    child: Text(
                      '24 Karat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: dashboardController.selectedKarat.value == '24'
                            ? const Color(0xFFFFE998)
                            : Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get _getCategoryListWidget => ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: dashboardController.designCategoryModel!.data.length,
        itemBuilder: (ctx, index) => CategoryDesignListItemWidget(
          dashboardController: dashboardController,
          designCategoryItemModel:
              dashboardController.designCategoryModel!.data[index],
        ),
      );
// Widget get _getCategoryListWidget => GridView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: dashboardController.designCategoryModel!.data.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         childAspectRatio: 1 / 1.2,
//         crossAxisSpacing: 0,
//         mainAxisSpacing: 0,
//       ),
//       itemBuilder: (ctx, index) => CategoryDesignListItemWidget(
//         dashboardController: dashboardController,
//         designCategoryItemModel:
//             dashboardController.designCategoryModel!.data[index],
//       ),
//     );
}
