import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/payment/controllers/payment_controller.dart';

class PaymentFailedWidget extends StatelessWidget {
  final String errString;
  final PaymentController paymentController;

  const PaymentFailedWidget({
    Key? key,
    required this.paymentController,
    required this.errString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'failure'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.textTheme.headlineMedium!.fontSize,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold),
                ),
                Lottie.asset(ImagesPath.orderFailure,
                    repeat: false,
                    options: LottieOptions(enableMergePaths: true)),
                Text(
                  errString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.find<CartController>().getUserCartApiCall();
                    Get.offNamedUntil(
                      AppRoutes.dashboardScreen,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 24.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(
                        color: Color(0xFFFFE998),
                      ),
                    ),
                  ),
                  child: Text(
                    'got_it'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 16.0,
            ),
            child: ElevatedButton(
              onPressed: () => paymentController.placeOrderApiCall(
                paymentMode: CommonConstants.paymentModeCash,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                ),
                backgroundColor: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'try_again'.tr,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
