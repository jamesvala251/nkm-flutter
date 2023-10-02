import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_history_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_history_model.dart'
    as orderItem;

class OrderInvoiceDownloadWidget extends StatelessWidget {
  final orderItem.Data orderHistoryItemModel;
  final OrderHistoryController orderHistoryController;
  final bool isCircularTypeCard;

  const OrderInvoiceDownloadWidget({
    Key? key,
    required this.orderHistoryItemModel,
    required this.orderHistoryController,
    required this.isCircularTypeCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => orderHistoryItemModel.isDownloading.value
          ? _getDownloadInProgressCard()
          : orderHistoryItemModel.hasErrorWhileDownloading.value
              ? _getDownloadErrorCard(context: context)
              : orderHistoryItemModel.downloadedInvoicePath.value.isEmpty
                  ? _getDownloadCard(context: context)
                  : _getDownloadedPdfCard(),
    );
  }

  Card _getDownloadCard({required BuildContext context}) {
    return Card(
      elevation: !isCircularTypeCard ? 0 : 2,
      color: Get.theme.primaryColor,
      margin: !isCircularTypeCard
          ? const EdgeInsets.only(top: 12)
          : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
      ),
      child: InkWell(
        onTap: () async {
          if (await orderHistoryController.askForStoragePermission(
              context: context)) {
            orderHistoryItemModel.downloadOrderInvoice();
          }
        },
        highlightColor: Colors.transparent,
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'download_invoice'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.download_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _getDownloadInProgressCard() {
    return Card(
      color: Colors.grey,
      elevation: !isCircularTypeCard ? 0 : 2,
      margin: !isCircularTypeCard
          ? const EdgeInsets.only(top: 12)
          : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              orderHistoryItemModel.downloadPercentage.value,
              style: TextStyle(
                fontSize: Get.textTheme.titleMedium!.fontSize,
                color: Get.theme.primaryColor,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Icon(
              Icons.downloading_rounded,
              color: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Card _getDownloadErrorCard({required BuildContext context}) {
    return Card(
      color: Colors.red,
      elevation: !isCircularTypeCard ? 0 : 2,
      margin: !isCircularTypeCard
          ? const EdgeInsets.only(top: 12)
          : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
      ),
      child: InkWell(
        onTap: () async {
          if (await orderHistoryController.askForStoragePermission(
              context: context)) {
            orderHistoryItemModel.downloadOrderInvoice();
          }
        },
        highlightColor: Colors.transparent,
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'try_again'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _getDownloadedPdfCard() {
    return Card(
      color: Colors.green,
      elevation: !isCircularTypeCard ? 0 : 2,
      margin: !isCircularTypeCard
          ? const EdgeInsets.only(top: 12)
          : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
      ),
      child: InkWell(
        onTap: () async {
          orderHistoryItemModel.openPDF();
        },
        highlightColor: Colors.transparent,
        borderRadius: !isCircularTypeCard
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'click_to_open'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.file_download_done_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
