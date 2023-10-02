import 'package:flutter/material.dart';
import 'package:get/get.dart';

AlertDialog logOutDialog({
  required VoidCallback onCancelBtnClick,
  required VoidCallback onLogoutBtnClick,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          7.0,
        ),
      ),
    ),
    content: Text(
      "are_you_sure_to_logout".tr,
      style: const TextStyle(
        color: Colors.black87,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onCancelBtnClick,
        child: Text(
          "cancel".tr,
          style: TextStyle(
            fontSize: Get.textTheme.labelLarge!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(
        width: 8.0,
      ),
      TextButton(
        onPressed: onLogoutBtnClick,
        child: Text(
          "log_out".tr,
          style: TextStyle(
            fontSize: Get.textTheme.labelLarge!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
