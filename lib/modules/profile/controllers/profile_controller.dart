import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/get_user_profile_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/version_info_model.dart';
import 'package:nkm_nose_pins_llp/modules/profile/models/update_user_profile_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/services/firebase_fcm_token_service.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class ProfileController extends GetxController {
  late String dialCode = '+91'; //+91 is default dialCode
  late String countryName = 'India';

  final RxBool isProfileLoading = true.obs;
  final RxString errorStringWhileLoadingProfile = ''.obs;
  late GetUserProfileModel? getUserProfileModel;

  final RxInt appVersionCode = 1.obs;
  final RxString versionName = '1.0.0'.obs;
  late String packageName = '';

  final MethodChannel _commonMethodChannel = const MethodChannel(
    CommonConstants.nkmMethodChannel,
  );

  @override
  void onInit() {
    super.onInit();
    _updateVersionInfoApiCall();
    getUserProfileApiCall();
    _updateFcmTokenApiCall();
  }

  void _updateVersionInfoApiCall() async {
    try {
      Object? object = await _commonMethodChannel
          .invokeMethod(CommonConstants.getVersionNameAndVersionCodeMethod);
      if (object != null) {
        Map<Object?, Object?> receivedMap = object as Map<Object?, Object?>;
        versionName.value =
            receivedMap[CommonConstants.nativeDataMapKeyVersionName]! as String;
        appVersionCode.value =
            receivedMap[CommonConstants.nativeDataMapKeyVersionCode]! as int;
        packageName =
            receivedMap[CommonConstants.nativeDataMapKeyPackageName]! as String;

        print('Version Name From Native: ${versionName.value}');
        print('Version Code From Native: ${appVersionCode.value}');
        print('Package Name From Native: $packageName');

        VersionInfoModel versionInfoModel =
            await ApiImplementer.versionInfoApiCall();

        if (versionInfoModel.data != null) {
          if (versionInfoModel.data!.versionCode > appVersionCode.value) {
            Map<String, dynamic> argumentMap = {
              RouteConstants.severity: versionInfoModel.data!.severity,
              RouteConstants.packageName: packageName,
            };

            if (versionInfoModel.data!.severity ==
                CommonConstants.appUpdateSeverityForceUpdate) {
              Get.offAllNamed(
                AppRoutes.updateAppScreen,
                arguments: argumentMap,
              );
              return;
            }
            Get.toNamed(
              AppRoutes.updateAppScreen,
              arguments: argumentMap,
            );
            return;
          }
          return;
        }
        print('Error In Update Version Info API Getting Data Obj Null!');
        return;
      }
    } catch (err) {
      print('Error In Update Version Info API!');
      return;
    }
  }

  void _updateFcmTokenApiCall() async {
    try {
      String fcmToken = await FirebaseFcmTokenService.getFcmToken();
      if (fcmToken.trim().isEmpty) {
        return;
      }
      await ApiImplementer.updateFcmTokenApiCall(fcmToken: fcmToken);
      return;
    } catch (err) {
      print(err.toString());
      return;
    }
  }

  void getUserProfileApiCall() async {
    try {
      isProfileLoading.value = true;
      errorStringWhileLoadingProfile.value = '';
      getUserProfileModel = await ApiImplementer.getUseProfileApiCall();
      if (getUserProfileModel!.success) {
        isProfileLoading.value = false;
        errorStringWhileLoadingProfile.value = '';
        return;
      }
      isProfileLoading.value = false;
      errorStringWhileLoadingProfile.value = getUserProfileModel!.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingProfile.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isProfileLoading.value = false;
    } catch (error) {
      errorStringWhileLoadingProfile.value = error.toString();
      isProfileLoading.value = false;
    }
  }

  void updateUserProfileApiCall({
    required BuildContext context,
    required String fullName,
    required String panNo,
    required String gstNo,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      UpdateUserProfileModel updateUserProfile =
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

  Future<void> logoutApiCall({
    required BuildContext context,
  }) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      await ApiImplementer.logoutApiCall();
      await PreferenceObj.clearPreferenceDataAndLogout();
      Get.offAllNamed(AppRoutes.loginScreen);
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
