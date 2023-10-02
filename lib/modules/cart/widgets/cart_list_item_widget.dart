import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart'
    as cart_item;
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class CartListItemWidget extends StatelessWidget {
  final CartController cartController;
  final cart_item.CartItemData cartItemModel;

  const CartListItemWidget({
    Key? key,
    required this.cartController,
    required this.cartItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Transform.scale(
                scale: 1.5,
                child: CachedNetworkImage(
                  imageUrl: cartItemModel.productDetail!.image,
                  fit: BoxFit.contain,
                  height: 150,
                  alignment: Alignment.center,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: SpinKitSpinningLines(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagesPath.noImageAvailable,
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
                            cartItemModel.productDetail!.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
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
                              title: 'delete_item'.tr,
                              description: 'are_you_sure_to_delete'.tr,
                              firstButtonName: 'no'.tr,
                              secondButtonName: 'yes'.tr,
                              onFirstButtonClicked: () => Get.back(),
                              onSecondButtonClicked: () {
                                Get.back();
                                cartController.removeFromCartApiCall(
                                  context: context,
                                  itemId: cartItemModel.id,
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
                          'article_no'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cartItemModel.articleNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              color: Get.theme.primaryColor,
                            ),
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
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cartItemModel.caretLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
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
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${cartItemModel.weight}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'making_charge_new'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '₹${cartItemModel.makingCharge}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'product_total'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Get.textTheme.titleSmall!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '₹${cartItemModel.totalPrice}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
