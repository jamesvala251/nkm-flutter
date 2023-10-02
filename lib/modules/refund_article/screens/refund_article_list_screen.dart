import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/controllers/filter_refund_article_controller.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/controllers/refund_article_list_controller.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/refund_article_bttom_sheet_widget.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/filter_refund_article_bottom_sheet_widget.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/refund_article_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class RefundArticleListScreen extends StatefulWidget {
  const RefundArticleListScreen({super.key});

  @override
  State<RefundArticleListScreen> createState() =>
      _RefundArticleListScreenState();
}

class _RefundArticleListScreenState extends State<RefundArticleListScreen> {
  final RefundArticleListController _refundArticleListController =
      Get.put(RefundArticleListController());
  final ScrollController _scrollController = ScrollController();
  final RxBool _displayScrollToTop = false.obs;

  @override
  void initState() {
    Get.put(FilterRefundArticleController());
    _refundArticleListController.getRefundArticleListApiCall();
    _scrollController.addListener(
      () {
        if (_scrollController.offset >= 400) {
          _displayScrollToTop.value = true;
        } else {
          _displayScrollToTop.value = false;
        }

        if (!_refundArticleListController.isLoadingArticleList.value &&
            !_refundArticleListController.isLoadingNextPage.value &&
            _refundArticleListController
                .errorWhileLoadingNextPage.value.isEmpty &&
            _refundArticleListController.hasMorePage.value &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent) {
          _refundArticleListController.loadNextRefundArticleListPage();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        title: Text('refund_article'.tr),
        actions: [
          IconButton(
            onPressed: () {
              _openFilterBottomSheet();
              return;
            },
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Obx(
        () => _refundArticleListController.isLoadingArticleList.value
            ? const LoadingWidget()
            : _refundArticleListController.errorStringArticleList.value.isEmpty
                ? _refundArticleListController.refundArticleList.isNotEmpty
                    ? _getRefundArticleList
                    : NoDataFoundWidget(
                        retryOn: () {
                          _refundArticleListController
                              .getRefundArticleListApiCall();
                        },
                      )
                : SomethingWentWrongWidget(
                    errorTxt: _refundArticleListController
                        .errorStringArticleList.value,
                    retryOnSomethingWentWrong: () {
                      _refundArticleListController
                          .getRefundArticleListApiCall();
                    },
                  ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(
            () => _displayScrollToTop.value
                ? FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _scrollToTop(),
                    mini: true,
                    clipBehavior: Clip.hardEdge,
                    child: const Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: 44,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                _openRefundArticleBottomSheet();
                return;
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
              // backgroundColor: Colors.red,
              icon: const Icon(
                Icons.rotate_left_rounded,
                color: Colors.white,
              ),
              label: Text(
                'refund_article'.tr,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  Column get _getRefundArticleList => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return await _refundArticleListController
                    .refreshRefundArticleListApiCall();
              },
              child: ListView.builder(
                itemCount:
                    _refundArticleListController.refundArticleList.length,
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  bottom: 150,
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                itemBuilder: (_, index) => RefundArticleListItemWidget(
                  refundArticleListItemModel:
                      _refundArticleListController.refundArticleList[index],
                ),
              ),
            ),
          ),
          _getLoadMoreWidget(),
        ],
      );

  Widget _getLoadMoreWidget() {
    return Obx(
      () => _refundArticleListController.isLoadingNextPage.value
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: SpinKitSpinningLines(
                      color: Get.theme.primaryColor,
                      size: 16,
                      itemCount: 2,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Page ${_refundArticleListController.pageNo.value} is loading...',
                    style: TextStyle(
                      fontSize: Get.textTheme.bodySmall!.fontSize,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            )
          : _refundArticleListController
                  .errorWhileLoadingNextPage.value.isNotEmpty
              ? InkWell(
                  onTap: () {
                    _refundArticleListController
                        .loadNextRefundArticleListPage();
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
                          _refundArticleListController
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

  void _openFilterBottomSheet() {
    Get.bottomSheet(
      FilterRefundArticleBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) {
      if (value != null && value) {
        Get.toNamed(AppRoutes.refundArticleFilterScreen);
      }
    });
  }

  void _openRefundArticleBottomSheet() {
    Get.bottomSheet(
      RefundArticleBottomSheetWidget(),
      isScrollControlled: true,
    );
  }
}
