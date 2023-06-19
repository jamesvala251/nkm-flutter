import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/add_design_to_cart_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/decrease_qty_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/increase_qty_model.dart';
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

  void addToOrderTotal({required int amountToAdd}) {
    try {
      orderTotal.value = orderTotal.value + amountToAdd;
    } catch (_) {}
  }

  void minusFromOrderTotal({required int amountToMinus}) {
    try {
      orderTotal.value = orderTotal.value - amountToMinus;
    } catch (_) {}
  }

  void getOrderTotalFromCartApi() async {
    try {
      GetUserCartItemsModel tempForTotal =
          await ApiImplementer.getCartApiCall();
      if (tempForTotal.success) {
        orderTotal.value = tempForTotal.orderTotalAmount;
        return;
      }
    } catch (_) {}
  }

  void getUserCartApiCall() async {
    try {
      isLoadingCart.value = true;
      errorStringWhileLoadingCart.value = '';
      getUserCartItemsModel.value = await ApiImplementer.getCartApiCall();
      if (getUserCartItemsModel.value!.success) {
        cartItemCount.value = getUserCartItemsModel.value!.data.length;
        orderTotal.value = getUserCartItemsModel.value!.orderTotalAmount;
        isLoadingCart.value = false;
        errorStringWhileLoadingCart.value = '';
        return;
      }
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
      // if (tempGetUserCartItModel.success) {
      getUserCartItemsModel.value = tempGetUserCartItModel;
      orderTotal.value = tempGetUserCartItModel.orderTotalAmount;
      cartItemCount.value = getUserCartItemsModel.value!.data.length;
      return;
      // }
      return;
    } catch (_) {
      return;
    }
  }

  Future<bool> addToCartApiCall({
    required BuildContext context,
    required String designId,
    required String goldKarat,
    required int designQty,
    required bool needToRefreshCart,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      AddDesignToCartModel tempAddDesignToCartModel =
          await ApiImplementer.addDesignToCartApiCall(
        designId: designId,
        goldKarat: goldKarat,
        designQty: designQty,
      );
      Get.back();
      if (tempAddDesignToCartModel.success &&
          tempAddDesignToCartModel.data != null) {
        getOrderTotalFromCartApi();
        if (needToRefreshCart) {
          refreshCartApiCall();
        }
        cartItemCount.value = tempAddDesignToCartModel.data!.cartItemsCount;
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

  Future<int?> addToCartForDesignListApiCall({
    required BuildContext context,
    required String designId,
    required String goldKarat,
    required int designQty,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      AddDesignToCartModel tempAddDesignToCartModelNew =
          await ApiImplementer.addDesignToCartApiCall(
        designId: designId,
        goldKarat: goldKarat,
        designQty: designQty,
      );
      Get.back();
      if (tempAddDesignToCartModelNew.success &&
          tempAddDesignToCartModelNew.data != null) {
        getOrderTotalFromCartApi();
        cartItemCount.value = tempAddDesignToCartModelNew.data!.cartItemsCount;
        UiUtils.successSnackBar(message: tempAddDesignToCartModelNew.message);
        return tempAddDesignToCartModelNew.data!.cartItem!.id;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: tempAddDesignToCartModelNew.message,
        onOkBntClick: () => Get.back(),
      );
      return null;
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
      return null;
    } catch (error) {
      Get.back();
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
      return null;
    }
  }

  Future<bool> removeFromCartApiCall({
    required BuildContext context,
    required int designId,
    required String goldKarat,
    required int designQty,
    required bool needToRefreshCart,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      RemoveDesignFromCartModel removeDesignFromCartModel =
          await ApiImplementer.removeDesignFromCartApiCall(
        designId: designId,
      );
      Get.back();
      if (removeDesignFromCartModel.success &&
          removeDesignFromCartModel.data != null) {
        getOrderTotalFromCartApi();
        if (needToRefreshCart) {
          refreshCartApiCall();
        }
        cartItemCount.value = removeDesignFromCartModel.data!.cartItemsCount;
        UiUtils.successSnackBar(message: removeDesignFromCartModel.message);
        return true;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: removeDesignFromCartModel!.message,
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

  Future<bool> incQtyApiCall({
    required BuildContext context,
    required int userCartId,
    required bool needToRefreshCart,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      IncreaseQuantityModel increaseQuantityModel =
          await ApiImplementer.increaseQtyApiCall(userCartId: userCartId);
      Get.back();
      if (increaseQuantityModel.success) {
        if (needToRefreshCart) {
          refreshCartApiCall();
        }
        return true;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: increaseQuantityModel.message,
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

  Future<bool> decQtyApiCall({
    required BuildContext context,
    required int userCartId,
    required bool needToRefreshCart,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      DecreaseQuantityModel decreaseQuantityModel =
          await ApiImplementer.decreaseQtyApiCall(userCartId: userCartId);
      Get.back();
      if (decreaseQuantityModel.success) {
        if (needToRefreshCart) {
          refreshCartApiCall();
        }
        return true;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: decreaseQuantityModel.message,
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
