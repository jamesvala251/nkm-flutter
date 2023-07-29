import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/register/controllers/register_controller.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/ui/common_style.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _panNo = TextEditingController();
  final TextEditingController _gstNo = TextEditingController();
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    PreferenceObj.setIsUserFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    double deviceAvailableHeight =
        Get.size.height - Get.mediaQuery.padding.vertical;

    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: deviceAvailableHeight * 0.08,
              ),
              Text(
                'register'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 0.9,
                ),
              ),
              Text(
                'create_new_account'.tr,
                style: TextStyle(
                  fontSize: Get.textTheme.titleLarge!.fontSize,
                  letterSpacing: 0.9,
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.02,
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
                height: deviceAvailableHeight * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 30,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle.getCommonTextFormFiledDecoration(
                  label: 'customer_name'.tr,
                  hintText: 'enter_customer_name'.tr,
                  iconData: Icons.person_rounded,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _shopName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 30,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle.getCommonTextFormFiledDecoration(
                  label: 'shop_name'.tr,
                  hintText: 'enter_shop_name'.tr,
                  iconData: Icons.shop_rounded,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _mobileNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration:
                    CommonStyle.getTextFormFiledDecorationForMobileNoFiled(
                  label: 'l_mobile_no'.tr,
                  hintText: 'h_mobile_no'.tr,
                  context: context,
                  dialCode: _registerController.dialCode,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                maxLength: 60,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle.getCommonTextFormFiledDecoration(
                  label: 'l_email'.tr,
                  hintText: 'h_email'.tr,
                  iconData: Icons.email_rounded,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _panNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 10,
                onChanged: (value) {
                  _panNo.value = _panNo.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle.getCommonTextFormFiledDecoration(
                  label: 'l_pan_no'.tr,
                  hintText: 'h_pan_no'.tr,
                  iconData: Icons.credit_card_rounded,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white70,
                controller: _gstNo,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                maxLength: 15,
                onChanged: (value) {
                  _gstNo.value = _gstNo.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle.getCommonTextFormFiledDecoration(
                  label: 'l_gst_no'.tr,
                  hintText: 'h_gst_no'.tr,
                  iconData: Icons.credit_card_rounded,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'l_ima'.tr,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: Get.textTheme.titleMedium!.fontSize),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _registerController.selectedRole.value =
                        RoleEnum.dealer,
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Obx(
                            () => Radio(
                              value: RoleEnum.dealer,
                              groupValue:
                                  _registerController.selectedRole.value,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white70),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (selectedRoleValue) =>
                                  _registerController.selectedRole.value =
                                      selectedRoleValue!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'dealer'.tr,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _registerController.selectedRole.value =
                        RoleEnum.shopKeeper,
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Obx(
                            () => Radio(
                              value: RoleEnum.shopKeeper,
                              groupValue:
                                  _registerController.selectedRole.value,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white70),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (selectedRoleValue) =>
                                  _registerController.selectedRole.value =
                                      selectedRoleValue!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'shopkeeper'.tr,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _registerController.selectedRole.value =
                        RoleEnum.semiDealer,
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Obx(
                            () => Radio(
                              value: RoleEnum.semiDealer,
                              groupValue:
                                  _registerController.selectedRole.value,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white70),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (selectedRoleValue) =>
                                  _registerController.selectedRole.value =
                                      selectedRoleValue!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'hawkers'.tr,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: Get.textTheme.titleMedium!.fontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceAvailableHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () => _validateForm(),
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
                  'sign_up'.tr.toUpperCase(),
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.transparent
                          ],
                          stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "or".tr.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.transparent
                          ],
                          stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Get.back();
                    return;
                  }
                  Get.offAllNamed(AppRoutes.loginScreen);
                  return;
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                  ),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.white)),
                ),
                child: Text(
                  'sign_in'.tr.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    if (_name.text.trim().isEmpty) {
      UiUtils.errorSnackBar(message: 'customer_name_err'.tr);
      return;
    } else if (_shopName.text.trim().isEmpty) {
      UiUtils.errorSnackBar(message: 'shop_name_err'.tr);
      return;
    } else if (_mobileNo.text.trim().isEmpty || _mobileNo.text.length != 10) {
      UiUtils.errorSnackBar(message: 'e_mobile_no'.tr);
      return;
    } else if (_email.text.trim().isEmpty) {
      UiUtils.errorSnackBar(message: 'e_email'.tr);
      return;
    } else if (_registerController.selectedRole.value == RoleEnum.none) {
      UiUtils.errorSnackBar(message: 'e_select_role'.tr);
      return;
    }

    _registerController.registerApiCall(
      context: context,
      name: _name.text.trim(),
      shopName: _shopName.text.trim(),
      mobileNo: _mobileNo.text.trim(),
      emailAddress: _email.text.trim(),
      panNo: _panNo.text.trim(),
      gstNo: _gstNo.text.trim(),
      canPop: Navigator.canPop(context),
    );
  }
}
