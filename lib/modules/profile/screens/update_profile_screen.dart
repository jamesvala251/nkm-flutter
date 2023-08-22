import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/profile/controllers/profile_controller.dart';
import 'package:nkm_nose_pins_llp/utils/ui/common_style.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ProfileController _profileController = Get.find<ProfileController>();

  final TextEditingController _fullName = TextEditingController();

  final TextEditingController _mobileNo = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _panNo = TextEditingController();

  final TextEditingController _gstNo = TextEditingController();
  final RxInt radioGroupValue = 0.obs;
  final RxBool _isEdited = false.obs;

  @override
  void initState() {
    super.initState();
    setUserProfileData();
  }

  void setUserProfileData() {
    _email.text = _profileController.getUserProfileModel!.data!.email;
    _fullName.text = _profileController.getUserProfileModel!.data!.name;
    _mobileNo.text = _profileController.getUserProfileModel!.data!.mobileNo;
    _panNo.text = _profileController.getUserProfileModel!.data!.panNo;
    _gstNo.text = _profileController.getUserProfileModel!.data!.gstNo;
    radioGroupValue.value =
        _profileController.getUserProfileModel!.data!.userType == "Dealer"
            ? 1
            : _profileController.getUserProfileModel!.data!.userType ==
                    "ShopKeeper"
                ? 2
                : _profileController.getUserProfileModel!.data!.userType ==
                        "Semi Dealer"
                    ? 3
                    : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit_profile".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: CircleAvatar(
                        child: Text(
                          _profileController
                              .getUserProfileModel!.data!.profileCircleName,
                          style: TextStyle(
                            fontSize: Get.textTheme.headlineMedium!.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Get.theme.primaryColor,
                controller: _fullName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 30,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle
                    .getCommonTextFormFiledDecorationForUpdateProfile(
                  label: 'full_name'.tr,
                  hintText: 'enter_full_name'.tr,
                  iconData: Icons.person_rounded,
                  isDisabled: false,
                ),
                onChanged: (_) => isEdited(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: false,
                cursorColor: Get.theme.primaryColor,
                controller: _mobileNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle
                    .getTextFormFiledDecorationForMobileNoFiledForUpdateProfile(
                  label: 'l_mobile_no'.tr,
                  hintText: 'h_mobile_no'.tr,
                  onCountrySelected: () {},
                  context: context,
                  dialCode: _profileController.dialCode,
                  needToShowFlag: false,
                  isDisabled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: false,
                cursorColor: Get.theme.primaryColor,
                controller: _email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                maxLength: 60,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle
                    .getCommonTextFormFiledDecorationForUpdateProfile(
                  label: 'l_email'.tr,
                  hintText: 'h_email'.tr,
                  iconData: Icons.email_rounded,
                  isDisabled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Get.theme.primaryColor,
                controller: _panNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 10,
                onChanged: (value) {
                  _panNo.value = _panNo.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                  isEdited();
                },
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle
                    .getCommonTextFormFiledDecorationForUpdateProfile(
                  label: 'l_pan_no'.tr,
                  hintText: 'h_pan_no'.tr,
                  iconData: Icons.credit_card_rounded,
                  isDisabled: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Get.theme.primaryColor,
                controller: _gstNo,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                maxLength: 15,
                onChanged: (value) {
                  _gstNo.value = _gstNo.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                  isEdited();
                },
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
                decoration: CommonStyle
                    .getCommonTextFormFiledDecorationForUpdateProfile(
                  label: 'l_gst_no'.tr,
                  hintText: 'h_gst_no'.tr,
                  iconData: Icons.credit_card_rounded,
                  isDisabled: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'l_ima'.tr,
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: Get.textTheme.titleMedium!.fontSize),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Radio(
                          value: 1,
                          groupValue: radioGroupValue.value,
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'dealer'.tr,
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: Get.textTheme.titleMedium!.fontSize,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Radio(
                          value: 2,
                          groupValue: radioGroupValue.value,
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'shopkeeper'.tr,
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: Get.textTheme.titleMedium!.fontSize,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Radio(
                          value: 3,
                          groupValue: radioGroupValue.value,
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'hawkers'.tr,
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: Get.textTheme.titleMedium!.fontSize,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              ElevatedButton(
                onPressed: () {
                  _validateForm();
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                    ),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Get.theme.primaryColor),
                child: Obx(
                  () => Text(
                    !_isEdited.value
                        ? 'edit'.tr.toUpperCase()
                        : 'save'.tr.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.textTheme.titleMedium!.fontSize,
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

  void isEdited() {
    try {
      if (_profileController.getUserProfileModel == null ||
          _profileController.getUserProfileModel!.data == null) {
        _isEdited.value = true;
        return;
      }
      if (_fullName.text.trim().toLowerCase() ==
              _profileController.getUserProfileModel!.data!.name
                  .trim()
                  .toLowerCase() &&
          _gstNo.text.trim().toLowerCase() ==
              _profileController.getUserProfileModel!.data!.gstNo
                  .trim()
                  .toLowerCase() &&
          _panNo.text.trim().toLowerCase() ==
              _profileController.getUserProfileModel!.data!.panNo
                  .trim()
                  .toLowerCase()) {
        _isEdited.value = false;
        return;
      }
      _isEdited.value = true;
      return;
    } catch (_) {}
  }

  void _validateForm() {
    if (_fullName.text.trim().isEmpty) {
      UiUtils.errorSnackBar(message: 'Enter Full Name'.tr);
      return;
    } else {
      _profileController.updateUserProfileApiCall(
        context: context,
        panNo: _panNo.text.trim(),
        gstNo: _gstNo.text.trim(),
        fullName: _fullName.text.trim(),
      );
    }
  }
}
