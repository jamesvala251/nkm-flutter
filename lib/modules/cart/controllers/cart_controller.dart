import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/add_design_to_cart_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/remove_design_from_cart_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class CartController extends GetxController {
  final RxBool isLoadingCart = true.obs;
  final RxString errorStringWhileLoadingCart = ''.obs;
  late Rx<GetUserCartItemsModel?> getUserCartItemsModel =
      Rx<GetUserCartItemsModel?>(null);
  final RxInt cartItemCount = 0.obs;
  final RxInt orderTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserCartApiCall();
  }

  void getUserCartApiCall() async {
    try {
      isLoadingCart.value = true;
      errorStringWhileLoadingCart.value = '';
      getUserCartItemsModel.value = await ApiImplementer.getCartApiCall();
      if (getUserCartItemsModel.value!.success &&
          getUserCartItemsModel.value!.data != null) {
        cartItemCount.value =
            getUserCartItemsModel.value!.data!.cartItemData.length;
        orderTotal.value = getUserCartItemsModel.value!.data!.total;
        isLoadingCart.value = false;
        errorStringWhileLoadingCart.value = '';
        return;
      }
      getUserCartItemsModel.value = null;
      cartItemCount.value = 0;
      orderTotal.value = 0;
      isLoadingCart.value = false;
      errorStringWhileLoadingCart.value = getUserCartItemsModel.value!.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingCart.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingCart.value = false;
    } catch (error) {
      errorStringWhileLoadingCart.value = error.toString();
      isLoadingCart.value = false;
    }
  }

  void refreshCartApiCall() async {
    try {
      GetUserCartItemsModel tempGetUserCartItModel =
          await ApiImplementer.getCartApiCall();
      if (tempGetUserCartItModel.success &&
          tempGetUserCartItModel.data != null) {
        getUserCartItemsModel.value = tempGetUserCartItModel;
        orderTotal.value = tempGetUserCartItModel.data!.total;
        cartItemCount.value =
            getUserCartItemsModel.value!.data!.cartItemData.length;
        return;
      }
      getUserCartItemsModel.value = null;
      orderTotal.value = 0;
      cartItemCount.value = 0;
      return;
    } catch (_) {
      return;
    }
  }

  Future<bool> addToCartApiCall({
    required BuildContext context,
    required int designId,
    required int articleId,
    required int caretId,
  }) async {
    try {
      AddDesignToCartModel tempAddDesignToCartModel =
          await ApiImplementer.addDesignToCartApiCall(
        designId: designId,
        articleId: articleId,
        caretId: caretId,
      );
      if (tempAddDesignToCartModel.success) {
        cartItemCount.value = tempAddDesignToCartModel.cartItemsCount;
        orderTotal.value = tempAddDesignToCartModel.total;
        UiUtils.successSnackBar(message: tempAddDesignToCartModel.message);
        return true;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: tempAddDesignToCartModel.message,
        onOkBntClick: () => Get.back(),
      );
      return false;
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
      rethrow;
    } catch (error) {
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
      rethrow;
    }
  }

  Future<bool> removeFromCartApiCall({
    required BuildContext context,
    required int itemId,
    required bool needToRefreshCart,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      RemoveDesignFromCartModel removeDesignFromCartModel =
          await ApiImplementer.removeDesignFromCartApiCall(
        itemId: itemId,
      );
      Get.back();
      if (removeDesignFromCartModel.success) {
        if (needToRefreshCart) {
          refreshCartApiCall();
        }
        cartItemCount.value = removeDesignFromCartModel.cartItemsCount;
        orderTotal.value = removeDesignFromCartModel.total;
        UiUtils.successSnackBar(message: removeDesignFromCartModel.message);
        return true;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: removeDesignFromCartModel.message,
        onOkBntClick: () => Get.back(),
      );
      return false;
    } on DioException catch (dioError) {
      Get.back();
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: errMsg,
        onOkBntClick: () => Get.back(),
      );
      rethrow;
    } catch (error) {
      Get.back();
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
      rethrow;
    }
  }
}
