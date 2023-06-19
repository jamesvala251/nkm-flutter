import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_history_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_history_model.dart'
    as orderHistoryModelAs;
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_invoice_download_widget.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class OrderHistoryListItemWidget extends StatelessWidget {
  final OrderHistoryController orderHistoryController;
  final orderHistoryModelAs.Data orderHistoryListItemModel;

  const OrderHistoryListItemWidget({
    Key? key,
    required this.orderHistoryController,
    required this.orderHistoryListItemModel,
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
          InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.orderDetailsScreen,
                arguments: {
                  RouteConstants.orderHistoryListItemModel: orderHistoryListItemModel,
                },
              );
            },
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
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
                        'order_no'.tr,
                        style: TextStyle(
                          fontSize: Get.textTheme.titleSmall!.fontSize,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        orderHistoryListItemModel.orderNo,
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
                                text: orderHistoryListItemModel.orderNo,
                              ),
                            );
                            UiUtils.successSnackBar(
                                message:
                                    '${orderHistoryListItemModel.orderNo} Copied!');
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
                        'order_date'.tr,
                        style: TextStyle(
                          fontSize: Get.textTheme.titleSmall!.fontSize,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        orderHistoryListItemModel.orderDate,
                        style: TextStyle(
                          fontSize: Get.textTheme.titleMedium!.fontSize,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'total_quantity'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Get.textTheme.titleSmall!.fontSize,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              '${orderHistoryListItemModel.totalQty}',
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
                              '₹${orderHistoryListItemModel.totalPrice}',
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
                          children: [
                            Text(
                              'order_status'.tr,
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
                                color: orderHistoryListItemModel.statusColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                orderHistoryListItemModel.status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Get.textTheme.titleSmall!.fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          orderHistoryListItemModel.invoice.isNotEmpty
              ? OrderInvoiceDownloadWidget(
                  orderHistoryItemModel: orderHistoryListItemModel,
                  orderHistoryController: orderHistoryController,
                  isCircularTypeCard: false,
                )
              : const SizedBox(
                  height: 8,
                ),
        ],
      ),
    );
  }
}
