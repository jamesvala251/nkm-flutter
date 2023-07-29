import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';

class GetGoldRateDetailWidget extends StatefulWidget {
  const GetGoldRateDetailWidget({super.key});

  @override
  State<GetGoldRateDetailWidget> createState() =>
      _GetGoldRateDetailWidgetState();
}

class _GetGoldRateDetailWidgetState extends State<GetGoldRateDetailWidget> {
  final DashboardController _dashboardController =
      Get.find<DashboardController>(
    tag: CommonConstants.dashboardControllerTag,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 8,
        // top: 12,
        // left: 12,
        // right: 12,
        // bottom: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Text(
                'gold_rate'.tr,
                style: const TextStyle(
                  color: Color(0xFFFFE998),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: _getDiffGoldRateList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _getDiffGoldRateList() {
    List<Widget> childrenList = [];

    for (int index = 0;
        index < _dashboardController.goldRateList.length;
        index++) {
      childrenList.addAll(
        [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    _dashboardController.goldRateList[index].label,
                    style: TextStyle(
                      color: const Color(0xFFFFE998),
                      fontSize: Get.textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                FittedBox(
                  child: Text(
                    '₹${_dashboardController.goldRateList[index].rate}',
                    style: TextStyle(
                      fontSize: Get.textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFE998),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index != (_dashboardController.goldRateList.length - 1))
            const VerticalDivider(
              width: 1,
              indent: 2,
              endIndent: 2,
              color: Color(0xFFFFE998),
            )
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: childrenList,
    );
  }
}
