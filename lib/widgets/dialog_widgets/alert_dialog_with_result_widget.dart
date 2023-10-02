import 'package:flutter/material.dart';
import 'package:get/get.dart';

AlertDialog alertDialogWithResultWidget({
  required String title,
  required String description,
  required String firstButtonName,
  required String secondButtonName,
  required VoidCallback onFirstButtonClicked,
  required VoidCallback onSecondButtonClicked,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(7.0),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: Get.textTheme.titleLarge!.fontSize,
      ),
    ),
    content: Text(
      description,
      style: TextStyle(
        color: Colors.black87,
        fontSize: Get.textTheme.titleMedium!.fontSize,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onFirstButtonClicked,
        child: Text(
          firstButtonName,
          style: TextStyle(
            fontSize: Get.textTheme.labelLarge!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(width: 8.0,),
      TextButton(
        onPressed: onSecondButtonClicked,
        child: Text(
          secondButtonName,
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
