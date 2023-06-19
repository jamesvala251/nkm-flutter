import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_history_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_detail_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_invoice_download_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_history_model.dart'
    as orderHistoryModelAs;

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderHistoryController _orderHistoryController =
      Get.find<OrderHistoryController>();
  late orderHistoryModelAs.Data orderHistoryListItemModel;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> argumentMap = Get.arguments as Map<String, dynamic>;
    orderHistoryListItemModel =
        argumentMap[RouteConstants.orderHistoryListItemModel]
            as orderHistoryModelAs.Data;
    _orderHistoryController.getOrderDetailsApiCall(
        orderId: orderHistoryListItemModel.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('order_details'.tr),
      ),
      body: Obx(
        () => _orderHistoryController.isLoadingOrderDetails.value
            ? const LoadingWidget()
            : _orderHistoryController
                    .errorStringWhileLoadingOrderDetails.value.isEmpty
                ? _getOrderDetailsWidget
                : SomethingWentWrongWidget(
                    retryOnSomethingWentWrong: () => _orderHistoryController
                        .errorStringWhileLoadingOrderDetails.value,
                  ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: orderHistoryListItemModel.invoice.isNotEmpty
          ? OrderInvoiceDownloadWidget(
              orderHistoryItemModel: orderHistoryListItemModel,
              orderHistoryController: Get.find<OrderHistoryController>(),
              isCircularTypeCard: true,
            )
          : const SizedBox(),
    );
  }

  Widget get _getOrderDetailsWidget => Container(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: _orderHistoryController.orderDetailsModel.data.length,
          itemBuilder: (ctx, index) => OrderHistoryListItemWidget(
            isFirstItem: index == 0,
            orderDetailListItemModel:
                _orderHistoryController.orderDetailsModel.data[index],
          ),
        ),
      );
}
