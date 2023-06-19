import 'package:flutter/material.dart';
import 'package:get/get.dart';

Stack progressWidget({
  String? msg,
}) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      UnconstrainedBox(
        child: Container(
          height: 74,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 5),
                blurRadius: 6.0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 18.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 16,
              ),
              Material(
                color: Colors.white,
                child: FittedBox(
                  child: Text(
                    msg ?? 'please_wait'.tr,
                    style: TextStyle(
                      fontSize: Get.textTheme.subtitle1!.fontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
