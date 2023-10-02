import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';

class CartBadgeWidget extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final Function? onBackResultCallBack;

  CartBadgeWidget({
    Key? key,
    this.onBackResultCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Badge(
        label: Text('${cartController.cartItemCount.value}'),
        largeSize: 16,
        backgroundColor: Colors.white,
        offset: const Offset(-8, 6),
        textColor: Get.theme.primaryColor,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        child: IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.cartScreen)!.then((result) {
              if (onBackResultCallBack != null) {
                onBackResultCallBack!(result);
                return;
              }
              return;
            });
          },
          icon: const Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
