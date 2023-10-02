import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/controllers/sub_category_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/gold_rates_widget.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/widgets/sub_category_design_list_item.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class SubCategoryDesignScreen extends StatefulWidget {
  const SubCategoryDesignScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryDesignScreen> createState() =>
      _SubCategoryDesignScreenState();
}

class _SubCategoryDesignScreenState extends State<SubCategoryDesignScreen> {
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());
  late String goldKarat;
  late String categoryId;
  late String categoryName;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> argument = Get.arguments as Map<String, dynamic>;
    goldKarat = argument[RouteConstants.goldKarat];
    categoryId = argument[RouteConstants.categoryId];
    categoryName = argument[RouteConstants.categoryName];
    _subCategoryController.getSubCategoryDesignApiCall(
      goldCaret: goldKarat,
      categoryId: categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryName),
        actions: [
          CartBadgeWidget(),
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
              () => _subCategoryController.isLoadingSubCateDesign.value
                  ? const LoadingWidget()
                  : _subCategoryController
                          .errorStringWhileLoadingSubCate.isEmpty
                      ? _subCategoryController.subCategoryList.isNotEmpty
                          ? Obx(
                              () => GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: _subCategoryController
                                    .subCategoryList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemBuilder: (ctx, index) =>
                                    SubCategoryDesignListItemWidget(
                                  subCategoryController: _subCategoryController,
                                  subCateItem: _subCategoryController
                                      .subCategoryList[index],
                                  goldKarat: goldKarat,
                                  categoryId: categoryId,
                                ),
                              ),
                            )
                          : NoDataFoundWidget(
                              retryOn: () => _subCategoryController
                                  .getSubCategoryDesignApiCall(
                                goldCaret: goldKarat,
                                categoryId: categoryId,
                              ),
                            )
                      : SomethingWentWrongWidget(
                          errorTxt: _subCategoryController
                              .errorStringWhileLoadingSubCate.value,
                          retryOnSomethingWentWrong: () =>
                              _subCategoryController
                                  .getSubCategoryDesignApiCall(
                            goldCaret: goldKarat,
                            categoryId: categoryId,
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
