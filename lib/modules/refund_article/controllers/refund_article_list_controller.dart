import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_list_model.dart'
    as refund_article_list_model;
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class RefundArticleListController extends GetxController {
  final RxBool isLoadingArticleList = true.obs;
  final RxString errorStringArticleList = ''.obs;
  final RxList<refund_article_list_model.Data> refundArticleList =
      RxList<refund_article_list_model.Data>([]);
  final RxInt pageNo = 1.obs;

  final RxBool isLoadingNextPage = false.obs;
  final RxString errorWhileLoadingNextPage = ''.obs;
  final RxBool hasMorePage = true.obs;

  void getRefundArticleListApiCall() async {
    try {
      pageNo.value = 1;
      refundArticleList.clear();
      isLoadingArticleList.value = true;
      errorStringArticleList.value = '';
      refund_article_list_model.RefundArticleListModel
          tempRefundArticleListModel =
          await ApiImplementer.getRefundArticleListApiCall(
        page: pageNo.value,
      );
      if (tempRefundArticleListModel.success) {
        isLoadingArticleList.value = false;
        refundArticleList.value = tempRefundArticleListModel.data;
        errorStringArticleList.value = '';
        return;
      }
      isLoadingArticleList.value = false;
      errorStringArticleList.value = tempRefundArticleListModel.message;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingArticleList.value = false;
      errorStringArticleList.value = errMsg;
      return;
    } catch (error) {
      isLoadingArticleList.value = false;
      errorStringArticleList.value = error.toString();
      return;
    }
  }

  void loadNextRefundArticleListPage() async {
    try {
      pageNo.value++;
      isLoadingNextPage.value = true;
      errorWhileLoadingNextPage.value = '';
      hasMorePage.value = true;
      refund_article_list_model.RefundArticleListModel
          tempRefundArticleListModel =
          await ApiImplementer.getRefundArticleListApiCall(
        page: pageNo.value,
      );
      if (tempRefundArticleListModel.success) {
        if (tempRefundArticleListModel.data.isEmpty) {
          isLoadingNextPage.value = false;
          errorWhileLoadingNextPage.value = '';
          hasMorePage.value = false;
          return;
        }
        refundArticleList.addAll(tempRefundArticleListModel.data);
        isLoadingNextPage.value = false;
        errorWhileLoadingNextPage.value = '';
        hasMorePage.value = true;
        return;
      }
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = tempRefundArticleListModel.message;
      hasMorePage.value = true;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = errMsg;
      hasMorePage.value = true;
      return;
    } catch (error) {
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = error.toString();
      hasMorePage.value = true;
      return;
    }
  }

  Future<void> refreshRefundArticleListApiCall() async {
    try {
      pageNo.value = 1;
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = '';
      hasMorePage.value = true;
      refund_article_list_model.RefundArticleListModel
          tempRefundArticleListModel =
          await ApiImplementer.getRefundArticleListApiCall(
        page: pageNo.value,
      );
      if (tempRefundArticleListModel.success &&
          tempRefundArticleListModel.data.isNotEmpty) {
        refundArticleList.value = tempRefundArticleListModel.data;
        return;
      }
      UiUtils.errorSnackBar(message: tempRefundArticleListModel.message);
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      UiUtils.errorSnackBar(message: errMsg);
      return;
    } catch (error) {
      UiUtils.errorSnackBar(message: error.toString());
      return;
    }
  }

  Future<void> refreshOnlyFirstPageAfterRefundArticleApiCall() async {
    try {
      refund_article_list_model.RefundArticleListModel
          tempNewOn1PageRefundArticleListModel =
          await ApiImplementer.getRefundArticleListApiCall(
        page: 1,
      );
      if (tempNewOn1PageRefundArticleListModel.success &&
          tempNewOn1PageRefundArticleListModel.data.isNotEmpty) {
        for (var item in tempNewOn1PageRefundArticleListModel.data) {
          if (refundArticleList
                  .firstWhereOrNull((element) => element.id == item.id) ==
              null) {
            refundArticleList.insert(0, item);
          }
        }
        return;
      }
      UiUtils.errorSnackBar(
          message: tempNewOn1PageRefundArticleListModel.message);
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      UiUtils.errorSnackBar(message: errMsg);
      return;
    } catch (error) {
      UiUtils.errorSnackBar(message: error.toString());
      return;
    }
  }

  Future<void> refundArticleApiCall({
    required BuildContext context,
    required int articleNumber,
  }) async {
    try {
      RefundArticleModel tempRefundArticleModel =
          await ApiImplementer.refundArticleApiCall(
        articleNumber: articleNumber,
      );
      if (tempRefundArticleModel.success) {
        refreshOnlyFirstPageAfterRefundArticleApiCall();
        UiUtils.successSnackBar(message: tempRefundArticleModel.message);
        return;
      }
      UiUtils.errorSnackBar(message: tempRefundArticleModel.message);
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: errMsg,
        onOkBntClick: () => Get.back(),
      );
      return;
    } catch (error) {
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
      return;
    }
  }
}
