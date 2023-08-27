import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/marquee_lib/marquee.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_option_selection_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/gold_rates_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    _cartController.getUserCartApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('shopping_cart'.tr),
        actions: [
          AbsorbPointer(
            child: CartBadgeWidget(),
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
      body: Obx(
        () => _cartController.isLoadingCart.value
            ? const LoadingWidget()
            : _cartController.errorStringWhileLoadingCart.value.isEmpty &&
                    _cartController.getUserCartItemsModel.value?.data != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 24.0,
                        child: Marquee(
                          text: "your_cart_item_will_be_removed_after_six_hours"
                              .tr,
                          style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: Get.textTheme.titleLarge!.fontSize),
                        ),
                      ),
                      GoldRatesWidget(),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: _cartController.getUserCartItemsModel
                              .value!.data!.cartItemData.length,
                          itemBuilder: (ctx, index) => CartListItemWidget(
                            cartController: _cartController,
                            cartItemModel: _cartController.getUserCartItemsModel
                                .value!.data!.cartItemData[index],
                          ),
                        ),
                      ),
                    ],
                  )
                : NoDataFoundWidget(
                    infoTxt: 'your_cart_is_empty'.tr,
                    retryOn: () => _cartController.getUserCartApiCall(),
                    icon: Icon(
                      Icons.shopping_basket_rounded,
                      size: 150,
                      color: Get.theme.primaryColor,
                    ),
                  ),
      ),
      bottomSheet: Obx(
        () => _cartController.isLoadingCart.value
            ? const SizedBox()
            : _cartController.errorStringWhileLoadingCart.value.isEmpty
                ? _cartController.getUserCartItemsModel.value?.data != null
                    ? Card(
                        margin: EdgeInsets.zero,
                        color: Colors.grey.shade100,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'order_total'.tr,
                                style: TextStyle(
                                  fontSize: Get.textTheme.titleMedium!.fontSize,
                                ),
                              ),
                              Text(
                                '₹${_cartController.getUserCartItemsModel.value!.data!.total}',
                                style: TextStyle(
                                  fontSize: Get.textTheme.titleLarge!.fontSize,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              const Spacer(),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 4,
                                ),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () =>
                                      _openBottomSheetForChoosePaymentOptions(),
                                  highlightColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'place_order'.tr.toUpperCase(),
                                          style: const TextStyle(
                                            letterSpacing: 1.1,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Icon(
                                          Icons.shopping_basket_rounded,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(),
      ),
    );
  }

  void _openBottomSheetForChoosePaymentOptions() {
    Get.bottomSheet(
      PaymentOptionSelectionWidget(),
      isScrollControlled: true,
    );
  }
}
