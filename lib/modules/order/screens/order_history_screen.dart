import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_history_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/widgets/order_history_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final OrderHistoryController _orderHistoryController =
      Get.put(OrderHistoryController());
  final ScrollController _scrollController = ScrollController();
  final RxBool _displayScrollToTop = false.obs;

  @override
  void initState() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >= 400) {
          _displayScrollToTop.value = true;
        } else {
          _displayScrollToTop.value = false;
        }

        if (!_orderHistoryController.isLoadingOrderHistory.value &&
            !_orderHistoryController.isLoadingNextPage.value &&
            _orderHistoryController.errorWhileLoadingNextPage.value.isEmpty &&
            _orderHistoryController.hasMorePage.value &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent) {
          _orderHistoryController.loadNextOrderHistoryPage();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('order_history'.tr),
      ),
      body: Obx(
        () => _orderHistoryController.isLoadingOrderHistory.value
            ? const LoadingWidget()
            : _orderHistoryController.errorStringOrderHistory.value.isEmpty
                ? _orderHistoryController.orderList.isNotEmpty
                    ? _getOrderHistoryList
                    : NoDataFoundWidget(
                        retryOn: () {
                          _orderHistoryController.getOrderHistoryApiCall();
                        },
                      )
                : SomethingWentWrongWidget(
                    errorTxt:
                        _orderHistoryController.errorStringOrderHistory.value,
                    retryOnSomethingWentWrong: () {
                      _orderHistoryController.getOrderHistoryApiCall();
                    },
                  ),
      ),
    );
  }

  Container get _getOrderHistoryList => Container(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      return await _orderHistoryController
                          .refreshOrderHistoryApiCall();
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _orderHistoryController.orderList.length,
                      itemBuilder: (ctx, index) => OrderHistoryListItemWidget(
                        orderHistoryController: _orderHistoryController,
                        orderHistoryListItemModel:
                            _orderHistoryController.orderList[index],
                      ),
                    ),
                  ),
                  Obx(
                    () => _displayScrollToTop.value
                        ? Positioned(
                            right: 16.0,
                            bottom: 16.0,
                            child: FloatingActionButton(
                              onPressed: () => _scrollToTop(),
                              mini: true,
                              child: const Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            _getLoadMoreWidget(),
          ],
        ),
      );

  Widget _getLoadMoreWidget() {
    return Obx(
      () => _orderHistoryController.isLoadingNextPage.value
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitSpinningLines(
                    color: Get.theme.primaryColor,
                    size: 16.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: Get.textTheme.bodySmall!.fontSize,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            )
          : _orderHistoryController.errorWhileLoadingNextPage.value.isNotEmpty
              ? InkWell(
                  onTap: () {
                    _orderHistoryController.loadNextOrderHistoryPage();
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          color: Get.theme.primaryColor,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          _orderHistoryController
                              .errorWhileLoadingNextPage.value,
                          style: TextStyle(
                            fontSize: Get.textTheme.bodySmall!.fontSize,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.linear,
    );
  }
}
