import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/register/models/register_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

enum RoleEnum { dealer, shopKeeper, semiDealer, none }

class RegisterController extends GetxController {
  late String dialCode = '+91 '; //+91 is default dialcode
  late String countryName = 'India';
  final Rx<RoleEnum> selectedRole = Rx<RoleEnum>(RoleEnum.dealer);

  void registerApiCall({
    required BuildContext context,
    required String name,
    required String shopName,
    required String mobileNo,
    required String emailAddress,
    required String panNo,
    required String gstNo,
    required bool canPop,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      RegisterUserModel registerUserModel =
          await ApiImplementer.registerUserApiCall(
        name: name,
        shopName: shopName,
        mobileNo: mobileNo,
        email: emailAddress,
        panNo: panNo,
        gstNo: gstNo,
        pinCode: '',
        role: selectedRole.value == RoleEnum.dealer
            ? 'dealer'
            : selectedRole.value == RoleEnum.shopKeeper
                ? 'shopkeeper'
                : 'semi dealer',
      );
      Get.back();
      if (registerUserModel.success) {
        UiUtils.successSnackBar(message: registerUserModel.message);
        if (canPop) {
          Get.back(result: mobileNo);
          return;
        }
        Get.offAllNamed(AppRoutes.loginScreen);
        return;
      }
      UiUtils.errorSnackBar(message: registerUserModel.message);
      return;
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
    } catch (error) {
      Get.back();
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
    }
  }
}
