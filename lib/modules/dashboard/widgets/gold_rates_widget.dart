import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/get_gold_rate_detail_widget.dart';

class GoldRatesWidget extends StatelessWidget {
  GoldRatesWidget({Key? key}) : super(key: key);

  final DashboardController dashboardController = Get.find<DashboardController>(
    tag: CommonConstants.dashboardControllerTag,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => dashboardController.isLoadingGoldRates.value
          ? const SizedBox()
          : dashboardController.goldRateErrorString.isEmpty
              ? const GetGoldRateDetailWidget()
              : _getGoldErrorWidget,
    );
  }

  Card get _getGoldErrorWidget => Card(
        margin: const EdgeInsets.only(
          top: 8,
          left: 12,
          right: 12,
          bottom: 8,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Adjust the border radius as desired
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  dashboardController.goldRateErrorString.value,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Get.textTheme.titleMedium!.fontSize,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () => dashboardController.getGoldRatesApiCall(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 10.0,
                  ),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'try_again'.tr,
                ),
              ),
            ],
          ),
        ),
      );
}
