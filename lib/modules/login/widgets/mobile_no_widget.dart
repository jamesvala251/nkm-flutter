import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/controllers/login_controller.dart';
import 'package:nkm_nose_pins_llp/modules/login/models/get_otp_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/screens/login_screen.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/utils/ui/common_style.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class MobileNoWidget extends StatefulWidget {
  final Function onPageChanged;
  final LoginController loginController;

  const MobileNoWidget({
    required this.onPageChanged,
    required this.loginController,
    Key? key,
  }) : super(key: key);

  @override
  State<MobileNoWidget> createState() => _MobileNoWidgetState();
}

class _MobileNoWidgetState extends State<MobileNoWidget> {
  final TextEditingController _mobileNo = TextEditingController();

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
                'welcome'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 0.9,
                ),
              ),
              Text(
                'sign_in_to_continue'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleLarge!.fontSize,
                  letterSpacing: 0.9,
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.07,
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
                height: deviceAvailableHeight * 0.07,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _mobileNo,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: 10,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    CommonStyle.getTextFormFiledDecorationForMobileNoFiled(
                  label: 'mobile_no'.tr,
                  hintText: 'enter_mobile_no'.tr,
                  onCountrySelected: _onCountrySelected,
                  context: context,
                  dialCode: widget.loginController.dialCode,
                  needToShowFlag: false,
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.07,
              ),
              ElevatedButton(
                onPressed: () {
                  String mobileNo = _mobileNo.text.trim();
                  if (mobileNo.isEmpty) {
                    UiUtils.errorSnackBar(message: 'please_enter_mobile_no'.tr);
                    return;
                  } else if (mobileNo.length != 10) {
                    UiUtils.errorSnackBar(
                        message: 'please_enter_valid_mobile_no'.tr);
                    return;
                  }
                  _getOtpApiCall(mobileNo: mobileNo);
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
                  'sign_in'.tr.toUpperCase(),
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.registerScreen)!
                        .then((mobileNoArg) {
                      if (mobileNoArg != null &&
                          mobileNoArg.toString().isNotEmpty) {
                        _mobileNo.text = mobileNoArg;
                        _getOtpApiCall(mobileNo: mobileNoArg);
                      }
                    }),
                    splashColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 4.0,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'do_not_have_account'.tr,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'sign_up'.tr,
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

  void _onCountrySelected(CountryCodeModel countryCodeModel) {
    widget.loginController.dialCode = countryCodeModel.dialCode;
    widget.loginController.countryName = countryCodeModel.name;
  }

  void _getOtpApiCall({required String mobileNo}) async {
    try {
      // String countryCode =
      //     widget.loginController.dialCode.replaceFirst('+', '');
      AppDialogs.showProgressDialog(
        context: context,
      );
      GetOtpModel getOtpModel = await ApiImplementer.getOtpApiCall(
        mobileNo: mobileNo,
      );
      Get.back();
      if (getOtpModel.success) {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.loginController.mobileNo = mobileNo;
        widget.onPageChanged(LoginEnum.verifyOtpPage);
        return;
      }
      UiUtils.errorSnackBar(message: getOtpModel.message);
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
