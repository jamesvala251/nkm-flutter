import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';

class PaymentSuccessWidget extends StatelessWidget {
  final String orderMsg;
  final CartController _cartController = Get.find<CartController>();

  PaymentSuccessWidget({
    Key? key,
    required this.orderMsg,
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
                  'order_placed'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.textTheme.headlineMedium!.fontSize,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold),
                ),
                Lottie.asset(
                  ImagesPath.orderSuccess,
                  repeat: false,
                  options: LottieOptions(enableMergePaths: true),
                ),
                Text(
                  orderMsg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.orderHistoryScreen)!.then(
                      (value) {
                        Get.back();
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'order_status'.tr,
                          style: TextStyle(
                            color: Get.theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Get.theme.colorScheme.primary,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 22.0,
                            color:  Color(0xFFFFE998),
                          ),
                        ),
                      ],
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
              onPressed: () {
                _cartController.getUserCartApiCall();
                Get.offNamedUntil(
                  AppRoutes.dashboardScreen,
                  (route) => false,
                );
              },
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
                'back_to_home'.tr,
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
