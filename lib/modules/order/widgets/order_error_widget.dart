import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_controller.dart';

class FailureOrderWidget extends StatelessWidget {
  final String errString;
  final OrderController orderController;

  const FailureOrderWidget({
    Key? key,
    required this.orderController,
    required this.errString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white70,
                radius: 65.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 50.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    child: Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Failed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0.8,
                ),
              ),
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
                height: 16,
              ),
              ElevatedButton(
                onPressed: () => orderController.placeOrderApiCall(),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 24.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.white),
                child: Text(
                  'try_again'.tr,
                  style: TextStyle(
                    color: Get.theme.primaryColor,
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
              Get.find<CartController>().getUserCartApiCall();
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
            child: const Text(
              'Back to Home',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
