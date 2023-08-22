import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/controllers/filter_refund_article_controller.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/filter_refund_article_bottom_sheet_widget.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/refund_article_bttom_sheet_widget.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/widgets/refund_article_list_item_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class RefundArticleFilterScreen extends StatefulWidget {
  const RefundArticleFilterScreen({super.key});

  @override
  State<RefundArticleFilterScreen> createState() =>
      _RefundArticleFilterScreenState();
}

class _RefundArticleFilterScreenState extends State<RefundArticleFilterScreen> {
  final FilterRefundArticleController _filterRefundArticleController =
      Get.find<FilterRefundArticleController>();
  final ScrollController _scrollController = ScrollController();
  final RxBool _displayScrollToTop = false.obs;

  @override
  void initState() {
    _filterRefundArticleController.getRefundArticleListApiCall();
    _scrollController.addListener(
      () {
        if (_scrollController.offset >= 400) {
          _displayScrollToTop.value = true;
        } else {
          _displayScrollToTop.value = false;
        }

        if (!_filterRefundArticleController.isLoadingRefundArticleList.value &&
            !_filterRefundArticleController.isLoadingNextPage.value &&
            _filterRefundArticleController
                .errorWhileLoadingNextPage.value.isEmpty &&
            _filterRefundArticleController.hasMorePage.value &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent) {
          _filterRefundArticleController.loadNextRefundArticleListPage();
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
            onPressed: () => _openFilterBottomSheet(),
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Obx(
        () => _filterRefundArticleController.isLoadingRefundArticleList.value
            ? const LoadingWidget()
            : _filterRefundArticleController
                    .errorStringRefundArticleList.value.isEmpty
                ? _filterRefundArticleController.refundArticleList.isNotEmpty
                    ? _getRefundArticleList
                    : NoDataFoundWidget(
                        retryOn: () {
                          _filterRefundArticleController
                              .getRefundArticleListApiCall();
                        },
                      )
                : SomethingWentWrongWidget(
                    errorTxt: _filterRefundArticleController
                        .errorStringRefundArticleList.value,
                    retryOnSomethingWentWrong: () {
                      _filterRefundArticleController
                          .getRefundArticleListApiCall();
                    },
                  ),
      ),
      floatingActionButton: Obx(
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
      bottomNavigationBar: Obx(
        () => _filterRefundArticleController.isLoadingRefundArticleList.value
            ? const SizedBox()
            : _filterRefundArticleController.isLoadingNextPage.value
                ? const SizedBox()
                : _filterRefundArticleController.isFilterApplied.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 4,
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Obx(
                                () => _filterRefundArticleController
                                            .articleNumber.value !=
                                        -1
                                    ? Card(
                                        color: Get.theme.primaryColor,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                            bottom: 4,
                                            left: 12,
                                            right: 4,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.numbers_rounded,
                                                size: Get.textTheme.titleMedium!
                                                    .fontSize,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'article_no'.tr,
                                                style: TextStyle(
                                                  fontSize: Get.textTheme
                                                      .titleMedium!.fontSize,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '${_filterRefundArticleController.articleNumber.value}',
                                                style: TextStyle(
                                                  fontSize: Get.textTheme
                                                      .titleMedium!.fontSize,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _filterRefundArticleController
                                                      .removeParticularFilter(
                                                    articleNoArg: true,
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.clear_rounded,
                                                  color: Colors.white,
                                                  size: 26,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
      ),
    );
  }

  Column get _getRefundArticleList => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return await _filterRefundArticleController
                    .refreshRefundArticleListApiCall();
              },
              child: ListView.builder(
                itemCount:
                    _filterRefundArticleController.refundArticleList.length,
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  bottom: 150,
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                itemBuilder: (_, index) => RefundArticleListItemWidget(
                  refundArticleListItemModel:
                      _filterRefundArticleController.refundArticleList[index],
                ),
              ),
            ),
          ),
          _getLoadMoreWidget(),
        ],
      );

  Widget _getLoadMoreWidget() {
    return Obx(
      () => _filterRefundArticleController.isLoadingNextPage.value
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
                    'Page ${_filterRefundArticleController.pageNo.value} is loading...',
                    style: TextStyle(
                      fontSize: Get.textTheme.bodySmall!.fontSize,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            )
          : _filterRefundArticleController
                  .errorWhileLoadingNextPage.value.isNotEmpty
              ? InkWell(
                  onTap: () {
                    _filterRefundArticleController
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
                          _filterRefundArticleController
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
    );
  }
}
