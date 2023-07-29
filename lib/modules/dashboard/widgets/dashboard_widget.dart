import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/gold_rates_model.dart'
    as gold_rate_model;
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
    return Obx(
      () => dashboardController.isLoadingGoldRates.value
          ? const LoadingWidget()
          : dashboardController.goldRateErrorString.isEmpty
              ? dashboardController.goldRateCategoryList.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getDesignCategorySelectionWidget,
                        Expanded(
                          child: Obx(
                            () => dashboardController
                                    .isLoadingDesignCategory.value
                                ? const LoadingWidget()
                                : dashboardController
                                        .errorStringWhileLoadingDesignCategory
                                        .isEmpty
                                    ? dashboardController
                                            .categoryList.isNotEmpty
                                        ? _getCategoryListWidget
                                        : NoDataFoundWidget(
                                            retryOn: () => dashboardController
                                                .getDesignCategoryApiCallNew(
                                              goldCaret: dashboardController
                                                  .selectedKarat.value,
                                            ),
                                          )
                                    : SomethingWentWrongWidget(
                                        errorTxt: dashboardController
                                            .errorStringWhileLoadingDesignCategory
                                            .value,
                                        retryOnSomethingWentWrong: () =>
                                            dashboardController
                                                .getDesignCategoryApiCallNew(
                                          goldCaret: dashboardController
                                              .selectedKarat.value,
                                        ),
                                      ),
                          ),
                        ),
                      ],
                    )
                  : SomethingWentWrongWidget(
                      errorTxt: dashboardController.goldRateErrorString.value,
                      retryOnSomethingWentWrong: () =>
                          dashboardController.getGoldRatesApiCall(),
                    )
              : SomethingWentWrongWidget(
                  errorTxt: dashboardController.goldRateErrorString.value,
                  retryOnSomethingWentWrong: () =>
                      dashboardController.getGoldRatesApiCall(),
                ),
    );
  }

  SizedBox get _getDesignCategorySelectionWidget => SizedBox(
        height: 48,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: dashboardController.goldRateCategoryList.length,
          itemBuilder: (ctx, index) => Obx(
            () => Card(
              margin: const EdgeInsets.only(
                left: 12,
                top: 8,
                right: 12,
                bottom: 4,
              ),
              color: dashboardController
                      .goldRateCategoryList[index].isSelected.value
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
                    : () {
                        gold_rate_model.GoldCategory goldCategory =
                            dashboardController.goldRateCategoryList.firstWhere(
                                (element) => element.isSelected.value);
                        goldCategory.isSelected.value = false;
                        dashboardController.goldRateCategoryList[index]
                            .isSelected.value = true;
                        dashboardController.selectedKarat.value =
                            dashboardController
                                .goldRateCategoryList[index].value;
                        dashboardController.getDesignCategoryApiCallNew(
                          goldCaret: dashboardController.selectedKarat.value,
                        );
                      },
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 18,
                  ),
                  child: Center(
                    child: Text(
                      dashboardController.goldRateCategoryList[index].label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: dashboardController
                                .goldRateCategoryList[index].isSelected.value
                            ? const Color(0xFFFFE998)
                            : Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _getCategoryListWidget => ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        itemCount: dashboardController.categoryList.length,
        itemBuilder: (ctx, index) => CategoryDesignListItemWidget(
          dashboardController: dashboardController,
          designCategoryItemModel: dashboardController.categoryList[index],
        ),
      );
}
