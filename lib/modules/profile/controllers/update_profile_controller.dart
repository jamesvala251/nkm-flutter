import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/profile/models/update_user_profile.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class UpdateProfileController extends GetxController{
  late String dialCode = '+91'; //+91 is default dialCode
  late String countryName = 'India';

  void updateProfileApiCall({
    required BuildContext context,
    required String fullName,
    required String panNo,
    required String gstNo,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      UpdateUserProfile updateUserProfile =
      await ApiImplementer.updateUserProfileApiCall(
       name: fullName,
        panNo: panNo,
        gstNo: gstNo,
      );
      Get.back();
      if (updateUserProfile.success) {
        UiUtils.successSnackBar(message: updateUserProfile.message);
        Get.back();
        return;
      }
      UiUtils.errorSnackBar(message: updateUserProfile.message);
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