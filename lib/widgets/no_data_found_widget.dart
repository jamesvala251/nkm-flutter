import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String infoTxt;
  final VoidCallback retryOn;
  final Icon? icon;

  const NoDataFoundWidget({
    required this.retryOn,
    this.infoTxt = '',
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == null
              ? Image.asset(
                  ImagesPath.noDataFound,
                  height: 200.0,
                  width: 200.0,
                )
              : icon!,
          const SizedBox(
            height: 16.0,
          ),
          Text(
            infoTxt.isEmpty ? 'no_data_found'.tr : infoTxt,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.primaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            onPressed: () => retryOn(),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text('try_again'.tr),
          ),
        ],
      ),
    );
  }
}
