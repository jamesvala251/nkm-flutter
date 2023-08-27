import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_list_model.dart'
    as refund_article_list_model;
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class FilterRefundArticleController extends GetxController {
  late RxInt articleNumber = (-1).obs;
  final RxBool isFilterApplied = false.obs;

  final RxBool isLoadingRefundArticleList = true.obs;
  final RxString errorStringRefundArticleList = ''.obs;
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
      isLoadingRefundArticleList.value = true;
      errorStringRefundArticleList.value = '';
      refund_article_list_model.RefundArticleListModel
          tempRefundArticleListModel =
          await ApiImplementer.getFilteredRefundArticleListApiCall(
        page: pageNo.value,
        articleNumber: articleNumber.value,
      );
      if (tempRefundArticleListModel.success) {
        isLoadingRefundArticleList.value = false;
        refundArticleList.value = tempRefundArticleListModel.data;
        errorStringRefundArticleList.value = '';
        return;
      }
      isLoadingRefundArticleList.value = false;
      errorStringRefundArticleList.value = tempRefundArticleListModel.message;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingRefundArticleList.value = false;
      errorStringRefundArticleList.value = errMsg;
      return;
    } catch (error) {
      isLoadingRefundArticleList.value = false;
      errorStringRefundArticleList.value = error.toString();
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
          await ApiImplementer.getFilteredRefundArticleListApiCall(
        page: pageNo.value,
        articleNumber: articleNumber.value,
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
          await ApiImplementer.getFilteredRefundArticleListApiCall(
        page: pageNo.value,
        articleNumber: articleNumber.value,
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

  void removeParticularFilter({
    bool articleNoArg = false,
  }) {
    if (articleNoArg) {
      isFilterApplied.value = false;
      articleNumber.value = -1;
      getRefundArticleListApiCall();
      return;
    }
    return;
  }

  void clearFilter() {
    isFilterApplied.value = false;
    articleNumber.value = -1;
    return;
  }
}
