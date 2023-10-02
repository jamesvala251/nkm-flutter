import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_list_model.dart'
    as refund_article_list_model;
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class RefundArticleListItemWidget extends StatelessWidget {
  final refund_article_list_model.Data refundArticleListItemModel;
  late DateTime parsedDate;

  RefundArticleListItemWidget({
    Key? key,
    required this.refundArticleListItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
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
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'order_number'.tr,
                  style: TextStyle(
                    fontSize: Get.textTheme.titleSmall!.fontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ': ${refundArticleListItemModel.orderDetails}',
                  style: TextStyle(
                    fontSize: Get.textTheme.titleMedium!.fontSize,
                    color: Get.theme.primaryColor,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    try {
                      Clipboard.setData(
                        ClipboardData(
                          text: refundArticleListItemModel.orderDetails,
                        ),
                      );
                      UiUtils.successSnackBar(
                          message:
                              '${refundArticleListItemModel.orderDetails} Copied!');
                    } catch (_) {}
                  },
                  child: const Icon(Icons.copy_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Row(
              children: [
                Text(
                  'refund_date'.tr,
                  style: TextStyle(
                    fontSize: Get.textTheme.titleSmall!.fontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ': ${refundArticleListItemModel.createdAtFormattedDate}',
                  style: TextStyle(
                    fontSize: Get.textTheme.titleMedium!.fontSize,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'article_number_new'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          refundArticleListItemModel.articalNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'karat'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          refundArticleListItemModel.caretLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'status'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: refundArticleListItemModel.refundStatusColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            refundArticleListItemModel.refundStatus,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'weight_mg'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          '${refundArticleListItemModel.weight}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'order_price'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          '₹${refundArticleListItemModel.orderTotalPrice}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'refund_amount'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          '₹${refundArticleListItemModel.totalRefundAmount}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
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
    );
  }
}
