import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/payment/controllers/payment_controller.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_failed_widget.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_success_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';

class QrScannerPaymentScreen extends StatefulWidget {
  const QrScannerPaymentScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerPaymentScreen> createState() => _QrScannerPaymentScreenState();
}

class _QrScannerPaymentScreenState extends State<QrScannerPaymentScreen> {
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  void initState() {
    _paymentController.placeOrderApiCall(
      paymentOption: CommonConstants.paymentOptionCash,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_paymentController.isLoadingOrder.value) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: _paymentController.isLoadingOrder.value
              ? Colors.grey.shade50
              : Get.theme.primaryColor,
          body: _paymentController.isLoadingOrder.value
              ? const LoadingWidget()
              : _paymentController.errorStringWhileLoadingOrder.isEmpty
                  ? PaymentSuccessWidget(
                      orderMsg: _paymentController.placeOrderModel.message,
                    )
                  : PaymentFailedWidget(
                      errString:
                          _paymentController.errorStringWhileLoadingOrder.value,
                      paymentController: _paymentController,
                    ),
        ),
      ),
    );
  }
}
