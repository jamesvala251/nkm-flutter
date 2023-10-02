import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonStyle {
  static InputDecoration getTextFormFiledDecorationForMobileNoFiled({
    required String label,
    required String hintText,
    required BuildContext context,
    required String dialCode,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 15.0,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Icon(
                Icons.call_rounded,
                size: 30.0,
                color: Colors.white60,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              dialCode,
              style: TextStyle(
                fontSize: Get.textTheme.titleMedium!.fontSize,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white70),
      ),
      labelStyle: const TextStyle(
        letterSpacing: 1.1,
        color: Colors.white70,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(letterSpacing: 1.1, color: Colors.white70),
      counterText: '',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }

  static InputDecoration getTextFormFiledDecorationForMessageFiled({
    required String hintText,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      prefixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Icon(
              Icons.message,
              size: 30.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
      hintText: hintText,
      hintStyle: const TextStyle(letterSpacing: 1.1),
      counterText: '',
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }

  static InputDecoration getCommonTextFormFiledDecoration({
    required String label,
    required String hintText,
    required IconData iconData,
    Widget? suffixIcon,
    VoidCallback? onSuffixIconPresses,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      suffixIcon: suffixIcon == null
          ? null
          : IconButton(icon: suffixIcon, onPressed: onSuffixIconPresses),
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Icon(
              iconData,
              size: 30.0,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white70),
      ),
      labelStyle: const TextStyle(
        letterSpacing: 1.1,
        color: Colors.white70,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        letterSpacing: 1.1,
        color: Colors.white70,
      ),
      counterText: '',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.white70,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }

  //for update profile
  static InputDecoration
      getTextFormFiledDecorationForMobileNoFiledForUpdateProfile({
    required String label,
    required String hintText,
    required Function onCountrySelected,
    required BuildContext context,
    required String dialCode,
    required needToShowFlag,
    required bool isDisabled,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 15.0,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Icon(
                Icons.call,
                size: 30.0,
                color: isDisabled ? Colors.grey : Get.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ' $dialCode ',
                  style: TextStyle(
                    fontSize: Get.textTheme.titleMedium!.fontSize,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      label: Text(
        label,
        style: TextStyle(color: Get.theme.primaryColor),
      ),
      labelStyle: TextStyle(
        letterSpacing: 1.1,
        color: Get.theme.primaryColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(letterSpacing: 1.1, color: Get.theme.primaryColor),
      counterText: '',
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }

  static InputDecoration
      getTextFormFiledDecorationForMessageFiledForUpdateProfile({
    required String hintText,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      prefixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Icon(
              Icons.message,
              size: 30.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
      hintText: hintText,
      hintStyle: const TextStyle(letterSpacing: 1.1),
      counterText: '',
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }

  static InputDecoration getCommonTextFormFiledDecorationForUpdateProfile({
    required String label,
    required String hintText,
    required IconData iconData,
    required bool isDisabled,
    Widget? suffixIcon,
    VoidCallback? onSuffixIconPresses,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      suffixIcon: suffixIcon == null
          ? null
          : IconButton(icon: suffixIcon, onPressed: onSuffixIconPresses),
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Icon(
              iconData,
              size: 30.0,
              color: isDisabled ? Colors.grey : Get.theme.primaryColor,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
      label: Text(
        label,
        style: TextStyle(color: Get.theme.primaryColor),
      ),
      labelStyle: TextStyle(
        letterSpacing: 1.1,
        color: Get.theme.primaryColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        letterSpacing: 1.1,
        color: Get.theme.primaryColor,
      ),
      counterText: '',
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Get.theme.primaryColor,
          width: 1.8,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.8,
        ),
      ),
    );
    return inputDecoration;
  }
}
