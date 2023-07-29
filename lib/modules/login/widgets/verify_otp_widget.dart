import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/custom_libs/pin_code_fields_lib/models/animation_type.dart';
import 'package:nkm_nose_pins_llp/custom_libs/pin_code_fields_lib/models/pin_theme.dart';
import 'package:nkm_nose_pins_llp/custom_libs/pin_code_fields_lib/pin_code_fields.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/login/controllers/login_controller.dart';
import 'package:nkm_nose_pins_llp/modules/login/models/get_otp_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/models/user_login_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/screens/login_screen.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class VerifyOtpWidget extends StatefulWidget {
  final Function onPageChanged;
  final LoginController loginController;

  const VerifyOtpWidget({
    required this.onPageChanged,
    required this.loginController,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyOtpWidget> createState() => _VerifyOtpWidgetState();
}

class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {
  final RxBool _waiting = true.obs;
  final TextEditingController _otpTextEditingController =
      TextEditingController();
  final double _totalOtpFiledWidth = (Get.width - 32.0) * 0.8;
  final RxBool _needToDisplayResendOption = false.obs;
  final RxInt _timerSecond = 120.obs;
  final RxInt _remainingMin = 0.obs;
  final RxInt _remainingSec = 0.obs;

  @override
  void initState() {
    super.initState();
    _startCountDownTimer();
  }

  @override
  Widget build(BuildContext context) {
    double deviceAvailableHeight =
        Get.size.height - Get.mediaQuery.padding.vertical;

    return SingleChildScrollView(
      child: SizedBox(
        height: deviceAvailableHeight,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: deviceAvailableHeight * 0.10,
              ),
              Text(
                'otp_verification'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 0.9,
                ),
              ),
              Text(
                'verify_otp_to_continue'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleLarge!.fontSize,
                  letterSpacing: 0.9,
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.05,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImagesPath.appLogo,
                  height: 94,
                  width: 220,
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.05,
              ),
              Center(
                child: Text(
                  'we_have_sent_a_otp_to_mobile_no'.tr,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: Get.theme.textTheme.titleMedium!.fontSize),
                ),
              ),
              Center(
                child: Text(
                  '+91 ${widget.loginController.mobileNo}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Get.theme.textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.04,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: _totalOtpFiledWidth - 6,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      showCursor: false,
                      cursorColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      controller: _otpTextEditingController,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      blinkDuration: const Duration(
                        milliseconds: 150,
                      ),
                      animationDuration: const Duration(
                        milliseconds: 300,
                      ),
                      pinTheme: PinTheme.defaults(
                        activeColor: Colors.white70,
                        inactiveColor: Colors.white70,
                        selectedColor: Colors.white70,
                        fieldWidth: _totalOtpFiledWidth / 4.8,
                      ),
                      textStyle: TextStyle(
                          fontSize: Get.textTheme.headlineSmall!.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                      onChanged: (enteredOtp) {
                        if (enteredOtp.length != 4) {
                          _waiting.value = true;
                          return;
                        }
                        _waiting.value = false;
                        return;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.07,
              ),
              ElevatedButton(
                onPressed: () {
                  String enteredOtp = _otpTextEditingController.text.trim();
                  if (enteredOtp.isEmpty || enteredOtp.length != 4) {
                    UiUtils.errorSnackBar(message: 'enter_otp'.tr);
                    return;
                  }
                  _loginApiCall(otp: enteredOtp);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                    ),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.white),
                child: Text(
                  'verify_and_proceed'.tr.toUpperCase(),
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.03,
              ),
              Obx(
                () => _needToDisplayResendOption.value == false
                    ? _getTimerWidget()
                    : Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => _resendOtpApiCall(),
                            splashColor: Colors.white,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'do_not_receive_otp'.tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Get.textTheme.titleMedium!.fontSize,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'resend_otp'.tr,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize:
                                          Get.textTheme.titleMedium!.fontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => widget.onPageChanged(LoginEnum.mobileNoPage),
                    splashColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 4.0,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'change_mobile_no'.tr,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'click_here'.tr,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: Get.textTheme.titleMedium!.fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTimerWidget() {
    return TextButton.icon(
      onPressed: null,
      icon: const Icon(
        Icons.timer,
        size: 34.0,
        color: Colors.white70,
      ),
      label: Obx(
        () => Text(
          '${_remainingMin.toString().padLeft(2, '0')}:${_remainingSec.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: Get.textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
    );
  }

  void _loginApiCall({required String otp}) async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      UserLoginModel userLoginModel = await ApiImplementer.loginApiCall(
        mobileNo: widget.loginController.mobileNo,
        otp: otp,
      );
      Get.back();
      if (userLoginModel.success &&
          userLoginModel.token != null &&
          userLoginModel.token!.isNotEmpty) {
        _storeLoginData(userLoginModel: userLoginModel);
        UiUtils.successSnackBar(message: userLoginModel.message);
        return;
      }
      AppDialogs.showInformationDialogue(
        context: context,
        barrierDismissible: false,
        title: 'err_occurred'.tr,
        description: userLoginModel.message,
        onOkBntClick: () => Get.back(),
      );
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

  void _resendOtpApiCall() async {
    try {
      AppDialogs.showProgressDialog(
        context: context,
      );
      GetOtpModel getOtpModel = await ApiImplementer.getOtpApiCall(
        mobileNo: widget.loginController.mobileNo,
      );
      Get.back();
      if (getOtpModel.success) {
        _needToDisplayResendOption.value = false;
        _resetCountDownTimer();
        _startCountDownTimer();
        UiUtils.successSnackBar(message: getOtpModel.message);
        return;
      }
      UiUtils.errorSnackBar(message: getOtpModel.message);
      Get.back();
      return;
    } on DioException catch (dioError) {
      _needToDisplayResendOption.value = true;
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
      _needToDisplayResendOption.value = true;
      Get.back();
      AppDialogs.showInformationDialogue(
        context: context,
        title: 'err_occurred'.tr,
        description: error.toString(),
        onOkBntClick: () => Get.back(),
      );
    }
  }

  void _storeLoginData({required UserLoginModel userLoginModel}) async {
    await PreferenceObj.setAuthToken(
      authToken: userLoginModel.token!,
    );
    Get.put(
      DashboardController(),
      permanent: true,
      tag: CommonConstants.dashboardControllerTag,
    );
    _goToDashboard();
    return;
  }

  void _goToDashboard() {
    Get.offAllNamed(
      AppRoutes.dashboardScreen,
    );
    return;
  }

  void _startCountDownTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      _timerSecond.value--;
      _remainingMin.value = _timerSecond.value ~/ 60;
      _remainingSec.value = _timerSecond.value % 60;
      if (_timerSecond.value <= 0) {
        _timerSecond.value = 120;
        _remainingMin.value = 0;
        _remainingSec.value = 0;
        _needToDisplayResendOption.value = true;
      }
      if (_needToDisplayResendOption.value == false) {
        _startCountDownTimer();
      }
    });
  }

  void _resetCountDownTimer() {
    _timerSecond.value = 120;
    _remainingMin.value = 0;
    _remainingSec.value = 0;
  }
}
