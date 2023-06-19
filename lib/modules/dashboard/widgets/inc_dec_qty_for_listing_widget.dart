import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/category_design_list_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart'
    as designCateItem;
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class IncDecQtyForListingWidget extends StatelessWidget {
  final CategoryDesignListController categoryDesignListController;
  final designCateItem.Data cateDesignListItem;
  final CartController cartController;
  final String goldKarat;

  const IncDecQtyForListingWidget({
    Key? key,
    required this.categoryDesignListController,
    required this.cateDesignListItem,
    required this.cartController,
    required this.goldKarat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              if (cateDesignListItem.userCartQty.value >= 1) {
                if (cateDesignListItem.userCartQty.value == 1) {
                  cateDesignListItem.userCartQty.value--;
                  cartController
                      .removeFromCartApiCall(
                    context: context,
                    designId: cateDesignListItem.designId,
                    goldKarat: goldKarat,
                    designQty: 0,
                    needToRefreshCart: true,
                  )
                      .then((result) {
                    if (!result) {
                      cateDesignListItem.userCartQty.value = 1;
                      return;
                    }
                    cartController.minusFromOrderTotal(
                      amountToMinus: cateDesignListItem.totalPrice,
                    );
                    return;
                  }).catchError((_) {
                    cateDesignListItem.userCartQty.value = 1;
                    return;
                  });
                  return;
                } else {
                  cateDesignListItem.userCartQty.value--;
                  cartController
                      .decQtyApiCall(
                    context: context,
                    userCartId: cateDesignListItem.userCartId!,
                    needToRefreshCart: false,
                  )
                      .then((result) {
                    if (!result) {
                      cateDesignListItem.userCartQty.value++;
                      return;
                    }
                    cartController.minusFromOrderTotal(
                      amountToMinus: cateDesignListItem.totalPrice,
                    );
                    return;
                  }).catchError((_) {
                    cateDesignListItem.userCartQty.value++;
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
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                child: Icon(
                  Icons.remove_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                AppDialogs.showNumberPicker(
                  context: context,
                  onValueSelected: (selectedNumber) {
                    cartController
                        .addToCartApiCall(
                      context: context,
                      designId: cateDesignListItem.designId.toString(),
                      goldKarat: goldKarat,
                      designQty: selectedNumber,
                      needToRefreshCart: false,
                    )
                        .then((result) {
                      if (result) {
                        cartController.minusFromOrderTotal(
                          amountToMinus: cateDesignListItem.userCartQty.value *
                              cateDesignListItem.totalPrice,
                        );
                        cateDesignListItem.userCartQty.value = selectedNumber;
                        cartController.addToOrderTotal(
                          amountToAdd: cateDesignListItem.userCartQty.value *
                              cateDesignListItem.totalPrice,
                        );
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
                child: Obx(
                  () => Text(
                    '${cateDesignListItem.userCartQty.value}',
                    style: TextStyle(
                      fontSize: Get.textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.w600,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              cateDesignListItem.userCartQty.value++;
              cartController
                  .incQtyApiCall(
                context: context,
                userCartId: cateDesignListItem.userCartId!,
                needToRefreshCart: false,
              )
                  .then((result) {
                if (!result) {
                  cateDesignListItem.userCartQty.value--;
                  return;
                }
                cartController.addToOrderTotal(
                  amountToAdd: cateDesignListItem.totalPrice,
                );
                return;
              }).catchError((_) {
                cateDesignListItem.userCartQty.value--;
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
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
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
