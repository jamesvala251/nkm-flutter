import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitSpinningLines(
            color: Get.theme.primaryColor,
            size: 44,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "loading".tr,
            style: const TextStyle(
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
