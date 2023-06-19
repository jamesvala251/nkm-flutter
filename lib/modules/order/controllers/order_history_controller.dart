import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_details_model.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_history_model.dart'
    as orderHistoryModelAs;
import 'package:nkm_nose_pins_llp/utils/helpers/custom_exception.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/permission_util.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';
import 'package:path_provider/path_provider.dart';

class OrderHistoryController extends GetxController {
  final RxBool isLoadingOrderHistory = true.obs;
  final RxString errorStringOrderHistory = ''.obs;
  final RxList<orderHistoryModelAs.Data> orderList =
      RxList<orderHistoryModelAs.Data>([]);
  final RxInt pageNo = 1.obs;

  final RxBool isLoadingOrderDetails = true.obs;
  final RxString errorStringWhileLoadingOrderDetails = ''.obs;
  late OrderDetailsModel orderDetailsModel;

  final RxBool isLoadingNextPage = false.obs;
  final RxString errorWhileLoadingNextPage = ''.obs;
  final RxBool hasMorePage = true.obs;

  // final RxBool isLoadingStoragePermission = true.obs;
  // final RxString hasErrorInStoragePermission = ''.obs;

  Directory? orderInvoiceFilesLocalStorageDirectory;
  final RxString invoiceVideoPath = ''.obs;

  final MethodChannel _commonMethodChannel = const MethodChannel(
    CommonConstants.nkmMethodChannel,
  );

  @override
  void onInit() {
    super.onInit();
    getOrderHistoryApiCall();
  }

  Future<String> getStorageDirectoryPath() async {
    try {
      if (orderInvoiceFilesLocalStorageDirectory != null) {
        return orderInvoiceFilesLocalStorageDirectory!.path;
      }

      final Directory? directory = await getExternalStorageDirectory();

      if (directory == null) {
        throw Exception('Directory Not Found!');
      }

      orderInvoiceFilesLocalStorageDirectory = Directory(
          '${directory.path}/${CommonConstants.nkmNosePinsLLPFolderName}');

      if (!await orderInvoiceFilesLocalStorageDirectory!.exists()) {
        await orderInvoiceFilesLocalStorageDirectory!.create(recursive: true);
      }

      return orderInvoiceFilesLocalStorageDirectory!.path;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> askForStoragePermission({required BuildContext context}) async {
    try {
      // isLoadingStoragePermission.value = true;
      // hasErrorInStoragePermission.value = '';

      Object? object = await _commonMethodChannel
          .invokeMethod(CommonConstants.getAndroidVersionMethod);
      int androidVersion = 0;

      if (object != null) {
        androidVersion = int.parse(object.toString().trim());
      }

      return await PermissionUtil.hasStoragePermission(
        isAndroidVersion13OrAbove: androidVersion >= 13,
      );

      // isLoadingStoragePermission.value =
      //     !await PermissionUtil.hasStoragePermission(
      //   isAndroidVersion13OrAbove: androidVersion >= 13,
      // );
      // hasErrorInStoragePermission.value = '';
    } catch (e) {
      String tempErr = (e as CustomException).errMessage;
      AppDialogs.showInformationDialogue(
        context: context,
        description: tempErr,
        onOkBntClick: () => Get.back(),
      );
      // isLoadingStoragePermission.value = false;
      return false;
    }
  }

  void getOrderHistoryApiCall() async {
    try {
      pageNo.value = 1;
      orderList.clear();
      isLoadingOrderHistory.value = true;
      errorStringOrderHistory.value = '';
      orderHistoryModelAs.OrderHistoryModel tempOrderHistoryModel =
          await ApiImplementer.getOrderHistoryApiCall(
        pageNo: pageNo.value,
      );
      if (tempOrderHistoryModel.success) {
        isLoadingOrderHistory.value = false;
        orderList.value = tempOrderHistoryModel.data;
        errorStringOrderHistory.value = '';
        return;
      }
      isLoadingOrderHistory.value = false;
      errorStringOrderHistory.value = tempOrderHistoryModel.message;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingOrderHistory.value = false;
      errorStringOrderHistory.value = errMsg;
      return;
    } catch (error) {
      isLoadingOrderHistory.value = false;
      errorStringOrderHistory.value = error.toString();
      return;
    }
  }

  void loadNextOrderHistoryPage() async {
    try {
      pageNo.value++;
      isLoadingNextPage.value = true;
      errorWhileLoadingNextPage.value = '';
      hasMorePage.value = true;
      orderHistoryModelAs.OrderHistoryModel tempOrderHistoryModelNew =
          await ApiImplementer.getOrderHistoryApiCall(
        pageNo: pageNo.value,
      );
      if (tempOrderHistoryModelNew.success) {
        if (tempOrderHistoryModelNew.data.isEmpty) {
          isLoadingNextPage.value = false;
          errorWhileLoadingNextPage.value = '';
          hasMorePage.value = false;
          return;
        }
        orderList.addAll(tempOrderHistoryModelNew.data);
        isLoadingNextPage.value = false;
        errorWhileLoadingNextPage.value = '';
        hasMorePage.value = true;
        return;
      }
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = tempOrderHistoryModelNew.message;
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

  Future<void> refreshOrderHistoryApiCall() async {
    try {
      pageNo.value = 1;
      isLoadingNextPage.value = false;
      errorWhileLoadingNextPage.value = '';
      hasMorePage.value = true;
      orderHistoryModelAs.OrderHistoryModel tempOrderHistoryModel =
          await ApiImplementer.getOrderHistoryApiCall(
        pageNo: pageNo.value,
      );
      if (tempOrderHistoryModel.success &&
          tempOrderHistoryModel.data.isNotEmpty) {
        orderList.value = tempOrderHistoryModel.data;
        return;
      }
      UiUtils.errorSnackBar(message: tempOrderHistoryModel.message);
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

  void getOrderDetailsApiCall({
    required int orderId,
  }) async {
    try {
      isLoadingOrderDetails.value = true;
      errorStringWhileLoadingOrderDetails.value = '';
      orderDetailsModel =
          await ApiImplementer.getOrderDetailsApiCall(orderId: orderId);
      if (orderDetailsModel.success) {
        isLoadingOrderDetails.value = false;
        errorStringWhileLoadingOrderDetails.value = '';
        return;
      }
      isLoadingOrderDetails.value = false;
      errorStringWhileLoadingOrderDetails.value = orderDetailsModel.message;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingOrderDetails.value = false;
      errorStringWhileLoadingOrderDetails.value = errMsg;
      return;
    } catch (error) {
      isLoadingOrderDetails.value = false;
      errorStringWhileLoadingOrderDetails.value = error.toString();
      return;
    }
  }
}
