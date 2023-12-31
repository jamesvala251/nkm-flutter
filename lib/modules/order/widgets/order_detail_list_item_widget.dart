import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_details_model.dart'
    as order_details_model_as;

class OrderHistoryListItemWidget extends StatelessWidget {
  final order_details_model_as.ArticleDetail articleDetailsModel;
  final bool isFirstItem;
  final RxBool isExpanded = false.obs;

  OrderHistoryListItemWidget({
    Key? key,
    required this.isFirstItem,
    required this.articleDetailsModel,
  }) : super(key: key) {
    isExpanded.value = isFirstItem;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isExpanded.value
                      ? Radius.zero
                      : const Radius.circular(12),
                  bottomRight: isExpanded.value
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            imageUrl: articleDetailsModel.designImage,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SpinKitSpinningLines(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            articleDetailsModel.designName,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            articleDetailsModel.caret,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => isExpanded.value = !isExpanded.value,
                      icon: Icon(
                        isExpanded.value
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded.value) ...[
              const Divider(height: 1, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 12,
                  right: 12,
                  bottom: 8,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'article_number'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            articleDetailsModel.articalNumber,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'gold_purity_diff'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            articleDetailsModel.caret,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'gold_price'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            '₹${articleDetailsModel.goldRate}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 8,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'total_weight'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            '${articleDetailsModel.weight}mg',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'making_charge'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            '₹${articleDetailsModel.makingCharge}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'total_price'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            '₹${articleDetailsModel.totalPrice}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
