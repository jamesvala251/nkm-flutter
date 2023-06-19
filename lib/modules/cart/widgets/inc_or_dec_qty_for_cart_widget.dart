import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart'
    as cartItem;
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class IncOrDecQtyForCartWidget extends StatelessWidget {
  final cartItem.Data cartItemModel;
  final CartController cartController;

  const IncOrDecQtyForCartWidget({
    Key? key,
    required this.cartItemModel,
    required this.cartController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              if (cartItemModel.designQty.value >= 1) {
                if (cartItemModel.designQty.value == 1) {
                  cartItemModel.designQty.value--;
                  cartController
                      .removeFromCartApiCall(
                    context: context,
                    designId: cartItemModel.designId,
                    goldKarat: cartItemModel.designCaret,
                    designQty: 0,
                    needToRefreshCart: true,
                  )
                      .then((result) {
                    if (!result) {
                      cartItemModel.designQty.value = 1;
                      return;
                    }
                    return;
                  }).catchError((_) {
                    cartItemModel.designQty.value = 1;
                    return;
                  });
                  return;
                } else {
                  cartItemModel.designQty.value--;
                  cartController
                      .decQtyApiCall(
                    context: context,
                    userCartId: cartItemModel.userCartId,
                    needToRefreshCart: true,
                  )
                      .then((result) {
                    if (!result) {
                      cartItemModel.designQty.value++;
                      return;
                    }
                    return;
                  }).catchError((_) {
                    cartItemModel.designQty.value++;
                    return;
                  });
                  return;
                }
              }
              return;
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            highlightColor: Colors.transparent,
            child: Card(
              margin: EdgeInsets.zero,
              color: Get.theme.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
                child: Icon(
                  Icons.remove_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AppDialogs.showNumberPicker(
                context: context,
                onValueSelected: (selectedNumber) {
                  cartController
                      .addToCartApiCall(
                    context: context,
                    designId: cartItemModel.designId.toString(),
                    goldKarat: cartItemModel.designCaret
                        .toLowerCase()
                        .replaceAll('k', ''),
                    designQty: selectedNumber,
                    needToRefreshCart: true,
                  )
                      .then((result) {
                    if (result) {
                      cartItemModel.designQty.value = selectedNumber;
                      return;
                    }
                    return;
                  });
                },
              );
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => Text(
                  '${cartItemModel.designQty.value}',
                  style: TextStyle(
                    fontSize: Get.textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.w600,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              cartItemModel.designQty.value++;
              cartController
                  .incQtyApiCall(
                context: context,
                userCartId: cartItemModel.userCartId,
                needToRefreshCart: true,
              )
                  .then((result) {
                if (!result) {
                  cartItemModel.designQty.value--;
                  return;
                }
                return;
              }).catchError((_) {
                cartItemModel.designQty.value--;
                return;
              });
              return;
            },
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            highlightColor: Colors.transparent,
            child: Card(
              margin: EdgeInsets.zero,
              color: Get.theme.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
