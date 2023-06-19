import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_error_widget.dart';
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_success_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class OrderResponseScreen extends StatefulWidget {
  const OrderResponseScreen({Key? key}) : super(key: key);

  @override
  State<OrderResponseScreen> createState() => _OrderResponseScreenState();
}

class _OrderResponseScreenState extends State<OrderResponseScreen> {
  final OrderController _orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_orderController.isLoadingOrder.value) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: _orderController.isLoadingOrder.value
              ? Colors.grey.shade50
              : _orderController.errorStringWhileLoadingOrder.isEmpty
                  ? Get.theme.primaryColor
                  : Colors.red,
          body: _orderController.isLoadingOrder.value
              ? const LoadingWidget()
              : _orderController.errorStringWhileLoadingOrder.isEmpty
                  ? OrderSuccessWidget(
                      orderMsg: _orderController.placeOrderModel.message,
                    )
                  : FailureOrderWidget(
                      errString:
                          _orderController.errorStringWhileLoadingOrder.value,
                      orderController: _orderController,
                    ),
        ),
      ),
    );
  }
}
