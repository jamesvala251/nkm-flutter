import 'package:flutter/material.dart';
import 'package:get/get.dart';

AlertDialog informationDialog({
  required String? title,
  required String description,
  required VoidCallback onOkBntClick,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          7.0,
        ),
      ),
    ),
    title: title == null
        ? null
        : Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: Get.textTheme.headline6!.fontSize,
            ),
          ),
    content: Text(
      description,
      style: const TextStyle(color: Colors.black87),
    ),
    actions: [
      TextButton(
        onPressed: onOkBntClick,
        child: Text(
          "Okay",
          style: TextStyle(
            fontSize: Get.textTheme.button!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
