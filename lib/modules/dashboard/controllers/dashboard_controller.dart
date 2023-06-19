import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_category_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/get_user_profile_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/gold_rates_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/services/firebase_fcm_token_service.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class DashboardController extends GetxController {
  final RxBool isLoadingGoldRates = true.obs;
  final RxString goldRateErrorString = ''.obs;
  late GoldRatesModel? goldRatesModel;

  final RxString selectedKarat = '18'.obs;

  final RxBool isLoadingDesignCategory = true.obs;
  final RxString errorStringWhileLoadingDesignCategory = ''.obs;
  late DesignCategoryModel? designCategoryModel;

  final RxBool isProfileLoading = true.obs;
  final RxString errorStringWhileLoadingProfile = ''.obs;
  late GetUserProfileModel? getUserProfileModel;

  @override
  void onInit() {
    super.onInit();
    _updateFcmTokenApiCall();
    getGoldRatesApiCall();
    getDesignCategoryApiCall(goldCaret: '18');
    getUserProfileApiCall();
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

  void getGoldRatesApiCall() async {
    try {
      isLoadingGoldRates.value = true;
      goldRateErrorString.value = '';
      goldRatesModel = await ApiImplementer.getGoldRatesApiCall();
      if (goldRatesModel!.success) {
        isLoadingGoldRates.value = false;
        goldRateErrorString.value = '';
        return;
      }
      isLoadingGoldRates.value = false;
      goldRateErrorString.value = goldRatesModel!.message;
      return;
    } on DioException catch (dioError) {
      goldRateErrorString.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingGoldRates.value = false;
    } catch (error) {
      goldRateErrorString.value = error.toString();
      isLoadingGoldRates.value = false;
    }
  }

  void getDesignCategoryApiCall({
    required String goldCaret,
  }) async {
    try {
      selectedKarat.value = goldCaret;
      isLoadingDesignCategory.value = true;
      errorStringWhileLoadingDesignCategory.value = '';
      designCategoryModel = await ApiImplementer.getDesignCategoryApiCall(
        goldCaret: goldCaret,
      );
      if (designCategoryModel!.success) {
        isLoadingDesignCategory.value = false;
        errorStringWhileLoadingDesignCategory.value = '';
        return;
      }
      isLoadingDesignCategory.value = false;
      errorStringWhileLoadingDesignCategory.value =
          designCategoryModel!.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingDesignCategory.value =
          Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingDesignCategory.value = false;
    } catch (error) {
      errorStringWhileLoadingDesignCategory.value = error.toString();
      isLoadingDesignCategory.value = false;
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
