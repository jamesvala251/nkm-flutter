import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/payment/controllers/payment_controller.dart';

class PaymentOptionSelectionWidget extends StatelessWidget {
  PaymentOptionSelectionWidget({super.key});

  final CartController _cartController = Get.find<CartController>();
  final Rx<PaymentMethod> selectedPaymentMethod =
      Rx<PaymentMethod>(PaymentMethod.qrScanner);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "payment_options".tr,
                        style: TextStyle(
                          fontSize: Get.textTheme.titleLarge!.fontSize!,
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      splashRadius: 12,
                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                      color: Get.theme.primaryColor,
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Get.theme.primaryColor,
                      Get.theme.primaryColor,
                      Get.theme.primaryColor,
                      Get.theme.primaryColor,
                      Colors.transparent
                    ],
                    stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectedPaymentMethod.value =
                            PaymentMethod.qrScanner,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: selectedPaymentMethod.value ==
                                    PaymentMethod.qrScanner
                                ? Get.theme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod.value ==
                                      PaymentMethod.qrScanner
                                  ? Get.theme.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: selectedPaymentMethod.value ==
                                        PaymentMethod.qrScanner
                                    ? const Color(0xFFFFE998)
                                    : Get.theme.primaryColor,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImagesPath.cashPaymentIcon,
                                    height: 64,
                                    width: 64,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "scan_qr".tr,
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleLarge!.fontSize,
                                      color: selectedPaymentMethod.value ==
                                              PaymentMethod.qrScanner
                                          ? Colors.white
                                          : Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            selectedPaymentMethod.value = PaymentMethod.online,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: selectedPaymentMethod.value ==
                                    PaymentMethod.online
                                ? Get.theme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod.value ==
                                      PaymentMethod.online
                                  ? Get.theme.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: selectedPaymentMethod.value ==
                                        PaymentMethod.online
                                    ? const Color(0xFFFFE998)
                                    : Get.theme.primaryColor,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImagesPath.onlinePaymentIcon,
                                    height: 64,
                                    width: 64,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "online".tr,
                                    style: TextStyle(
                                        fontSize:
                                            Get.textTheme.titleLarge!.fontSize,
                                        color: selectedPaymentMethod.value ==
                                                PaymentMethod.online
                                            ? Colors.white
                                            : Get.theme.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    if (selectedPaymentMethod.value ==
                        PaymentMethod.qrScanner) {
                      Get.toNamed(
                        AppRoutes.qrScannerPaymentScreen,
                      )!
                          .then((_) {
                        _cartController.refreshCartApiCall();
                        Get.offNamedUntil(
                          AppRoutes.dashboardScreen,
                          (route) => false,
                        );
                        return;
                      });
                      return;
                    } else {
                      Get.toNamed(AppRoutes.onlinePaymentScreen)!
                          .then((result) {
                        _cartController.refreshCartApiCall();
                        Get.offNamedUntil(
                          AppRoutes.dashboardScreen,
                          (route) => false,
                        );
                        return;
                      });
                      return;
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "done".tr,
                      style: TextStyle(
                          fontSize: Get.textTheme.titleMedium!.fontSize),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
