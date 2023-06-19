import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_dialog.dart';
import 'package:nkm_nose_pins_llp/widgets/dialog_widgets/alert_dialog_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/dialog_widgets/alert_dialog_with_result_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/dialog_widgets/information_dialog.dart';
import 'package:nkm_nose_pins_llp/widgets/dialog_widgets/log_out_dialog.dart';
import 'package:nkm_nose_pins_llp/widgets/dialog_widgets/progress_dialog_widget.dart';

class AppDialogs {
  //TODO Country Picker
  static Future<void> showCountryPickerDialog({
    required BuildContext context,
    bool barrierDismissible = true,
    required Function onCountrySelected,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      barrierColor: Colors.white,
      useSafeArea: true,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 40.0,
        ),
        child: CountryCodeDialog(
          onCountrySelected: onCountrySelected,
        ),
      ),
    );
  }

  //TODO Please Wait Dialog
  static Future<void> showProgressDialog({
    required BuildContext context,
    String? msg,
    bool isDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (ctx) => progressWidget(
        msg: msg,
      ),
    );
  }

//TODO Title,Subtitle Dialog
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String firstButtonName,
    required String secondButtonName,
    required VoidCallback onFirstButtonClicked,
    required VoidCallback onSecondButtonClicked,
    bool isDismissible = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogWidget(
          title: title,
          description: description,
          onFirstButtonClicked: onFirstButtonClicked,
          onSecondButtonClicked: onSecondButtonClicked,
          secondButtonName: secondButtonName,
          firstButtonName: firstButtonName,
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static Future<dynamic> showAlertDialogWithResult({
    required BuildContext context,
    required String title,
    required String description,
    required String firstButtonName,
    required String secondButtonName,
    required VoidCallback onFirstButtonClicked,
    required VoidCallback onSecondButtonClicked,
    bool isDismissible = false,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogWithResultWidget(
          title: title,
          description: description,
          onFirstButtonClicked: onFirstButtonClicked,
          onSecondButtonClicked: onSecondButtonClicked,
          secondButtonName: secondButtonName,
          firstButtonName: firstButtonName,
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static Future<bool> showExitAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String firstButtonName,
    required String secondButtonName,
    required VoidCallback onFirstButtonClicked,
    required VoidCallback onSecondButtonClicked,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogWidget(
          title: title,
          description: description,
          onFirstButtonClicked: onFirstButtonClicked,
          onSecondButtonClicked: onSecondButtonClicked,
          secondButtonName: secondButtonName,
          firstButtonName: firstButtonName,
        );
      },
      barrierDismissible: false,
    );
  }

  //TODO LogOut Dialog
  static Future<void> showLogoutDialogue({
    required BuildContext context,
    required VoidCallback onCancelBtnClick,
    required VoidCallback onLogoutBtnClick,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (ctx) => logOutDialog(
        onCancelBtnClick: onCancelBtnClick,
        onLogoutBtnClick: onLogoutBtnClick,
      ),
    );
  }

  //TODO Information Dialog
  static Future<void> showInformationDialogue({
    required BuildContext context,
    String? title,
    required String description,
    required VoidCallback onOkBntClick,
    String okBtnTxt = "okay",
    bool barrierDismissible = true,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (ctx) => informationDialog(
        title: title,
        description: description,
        onOkBntClick: onOkBntClick,
      ),
    );
  }

  //TODO Exit app
  static showExitAppDialogDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            title: Center(
              child: Text(
                'exit_app'.tr,
                style: TextStyle(fontSize: Get.textTheme.titleLarge!.fontSize),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'are_you_sure_to_exit_app'.tr,
                  style:
                      TextStyle(fontSize: Get.textTheme.titleMedium!.fontSize),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  'yes'.tr,
                  style: TextStyle(
                      fontSize: Get.textTheme.titleLarge!.fontSize,
                      color: Colors.white),
                ),
              ),
              TextButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'no'.tr,
                  style:
                      TextStyle(fontSize: Get.textTheme.titleLarge!.fontSize),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> showNumberPicker({
    required BuildContext context,
    required Function onValueSelected,
  }) {
    int selectedValue = 1;
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        onValueSelected(selectedValue);
                        Get.back();
                      },
                      child: Text(
                        'done'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 30,
                  offAxisFraction: 0.5,
                  onSelectedItemChanged: (int index) =>
                      selectedValue = index + 1,
                  children: List<Widget>.generate(200, (int index) {
                    return Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: Get.textTheme.titleLarge!.fontSize,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
