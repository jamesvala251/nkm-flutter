import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';

class OrderSuccessWidget extends StatelessWidget {
  final String orderMsg;
  final CartController _cartController = Get.find<CartController>();

  OrderSuccessWidget({
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
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(
              top: 40.0,
              right: 8.0,
            ),
            child: InkWell(
              onTap: () {
                _cartController.getUserCartApiCall();
                Get.offNamedUntil(
                  AppRoutes.dashboardScreen,
                  (route) => false,
                );
              },
              child: const Icon(
                Icons.close_rounded,
                size: 34.0,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade300,
                  radius: 65.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade200,
                    radius: 50.0,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.green,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  'Order Placed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  orderMsg,
                  //'Your order was placed successfully.\nYour order no is $orderNo.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
                          'Order Status',
                          style: TextStyle(
                            color: Get.theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 22.0,
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
                            color: Colors.white,
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
                'Back to Home',
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
