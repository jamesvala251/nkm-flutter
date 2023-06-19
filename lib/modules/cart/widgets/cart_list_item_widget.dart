import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart'
    as cartItem;
import 'package:nkm_nose_pins_llp/modules/cart/widgets/inc_or_dec_qty_for_cart_widget.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class CartListItemWidget extends StatelessWidget {
  final CartController cartController;
  final cartItem.Data cartItemModel;

  const CartListItemWidget({
    Key? key,
    required this.cartController,
    required this.cartItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 218,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CachedNetworkImage(
                          imageUrl: cartItemModel.designImage,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 0.8,
                        color: Colors.grey,
                        indent: 8,
                        endIndent: 8,
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItemModel.designName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Get
                                            .textTheme.titleMedium!.fontSize,
                                        fontWeight: FontWeight.w600,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AppDialogs.showAlertDialog(
                                        context: context,
                                        title: 'Delete Item?',
                                        description:
                                            'Are you sure want to delete this item from cart?',
                                        firstButtonName: 'No',
                                        secondButtonName: 'Yes',
                                        onFirstButtonClicked: () =>
                                            Get.back(),
                                        onSecondButtonClicked: () {
                                          Get.back();
                                          cartController
                                              .removeFromCartApiCall(
                                            context: context,
                                            designId: cartItemModel.designId,
                                            goldKarat:
                                                cartItemModel.designCaret,
                                            designQty: 1,
                                            needToRefreshCart: true,
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'gold_purity'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleSmall!.fontSize,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      cartItemModel.designCaret,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: Get
                                            .textTheme.titleMedium!.fontSize,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'weight'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleSmall!.fontSize,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      cartItemModel.designWeight,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: Get
                                            .textTheme.titleMedium!.fontSize,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'price'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleSmall!.fontSize,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '₹${cartItemModel.designPrice}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: Get
                                            .textTheme.titleMedium!.fontSize,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              IncOrDecQtyForCartWidget(
                                cartItemModel: cartItemModel,
                                cartController: cartController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.8,
                  color: Colors.grey,
                  indent: 8,
                  endIndent: 8,
                ),
                Flexible(
                  child: Container(
                    color: Colors.grey.shade50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'product_total'.tr,
                          style: TextStyle(
                              fontSize: Get.textTheme.titleSmall!.fontSize,
                              letterSpacing: 1.1),
                        ),
                        Text(
                          '₹${cartItemModel.designPrice} × ${cartItemModel.designQty} = ₹${cartItemModel.designTotalPrice}',
                          style: TextStyle(
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
