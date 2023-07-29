import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/payment/controllers/payment_controller.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class OnlinePaymentScreen extends StatefulWidget {
  const OnlinePaymentScreen({super.key});

  @override
  State<OnlinePaymentScreen> createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    _paymentController.placeOrderApiCall(
      paymentOption: CommonConstants.paymentOptionOnline,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('payment_screen'.tr),
      ),
      body: Obx(
        () => _paymentController.isLoadingOrder.value
            ? const LoadingWidget()
            : _paymentController.errorStringWhileLoadingOrder.isEmpty
                ? const Text('REPLACE_YOUR_CUSTOM_WIDGET_HERE')
                : SomethingWentWrongWidget(
                    errorTxt:
                        _paymentController.errorStringWhileLoadingOrder.value,
                    retryOnSomethingWentWrong: () {
                      _paymentController.placeOrderApiCall(
                        paymentOption: CommonConstants.paymentOptionOnline,
                      );
                    },
                  ),
      ),
    );
  }
}
