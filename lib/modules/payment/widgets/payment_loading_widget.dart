import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/three_bounce.dart';

class PaymentLoadingWidget extends StatelessWidget {
  const PaymentLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: Get.theme.primaryColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "payment_instruction".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: Get.textTheme.titleMedium!.fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
