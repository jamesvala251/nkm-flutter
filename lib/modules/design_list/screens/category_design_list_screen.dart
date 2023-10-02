import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/controllers/category_design_list_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/widgets/category_design_list_item.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/gold_rates_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class CategoryDesignListScreen extends StatefulWidget {
  const CategoryDesignListScreen({Key? key}) : super(key: key);

  @override
  State<CategoryDesignListScreen> createState() =>
      _CategoryDesignListScreenState();
}

class _CategoryDesignListScreenState extends State<CategoryDesignListScreen> {
  final CategoryDesignListController _categoryDesignListController =
      Get.put(CategoryDesignListController());
  final CartController _cartController = Get.find<CartController>();

  late String goldKarat;
  late String subCategoryId;
  late String subCategoryName;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> argument = Get.arguments as Map<String, dynamic>;
    goldKarat = argument[RouteConstants.goldKarat];
    subCategoryId = argument[RouteConstants.subCategoryId];
    subCategoryName = argument[RouteConstants.subCategoryName];
    _categoryDesignListController.getSubCategoryDesignListApiCall(
      goldCaret: goldKarat,
      subCategoryId: subCategoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          centerTitle: true,
          title: Text(subCategoryName),
          actions: [
            Obx(
              () => _cartController.orderTotal.value > 0
                  ? Wrap(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 18,
                            left: 6,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '₹${_cartController.orderTotal.value.toStringAsFixed(0)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            CartBadgeWidget(
              onBackResultCallBack: (result) {
                _categoryDesignListController.getSubCategoryDesignListApiCall(
                  goldCaret: goldKarat,
                  subCategoryId: subCategoryId,
                );
              },
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GoldRatesWidget(),
            Expanded(
              child: Obx(
                () => _categoryDesignListController
                        .isLoadingCateDesignList.value
                    ? const LoadingWidget()
                    : _categoryDesignListController
                            .errorStringWhileLoadingCateDesignList.isEmpty
                        ? _categoryDesignListController.designList.isNotEmpty
                            ? Obx(
                                () => ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: _categoryDesignListController
                                      .designList.length,
                                  itemBuilder: (ctx, index) =>
                                      CategoryDesignListItem(
                                    categoryDesignListController:
                                        _categoryDesignListController,
                                    cateDesignListItem:
                                        _categoryDesignListController
                                            .designList[index],
                                    cartController: _cartController,
                                    goldKarat: goldKarat,
                                    subCategoryId: subCategoryId,
                                  ),
                                ),
                              )
                            : NoDataFoundWidget(
                                retryOn: () => _categoryDesignListController
                                    .getSubCategoryDesignListApiCall(
                                  goldCaret: goldKarat,
                                  subCategoryId: subCategoryId,
                                ),
                              )
                        : SomethingWentWrongWidget(
                            errorTxt: _categoryDesignListController
                                .errorStringWhileLoadingCateDesignList.value,
                            retryOnSomethingWentWrong: () =>
                                _categoryDesignListController
                                    .getSubCategoryDesignListApiCall(
                              goldCaret: goldKarat,
                              subCategoryId: subCategoryId,
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
