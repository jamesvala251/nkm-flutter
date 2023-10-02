import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/dashboard_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/gold_rates_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/profile_widget.dart';
import 'package:nkm_nose_pins_llp/modules/profile/controllers/profile_controller.dart';
import 'package:nkm_nose_pins_llp/utils/services/firebase_deeplink_service.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RxInt _currentDashboardTabIndex = 0.obs;
  final DashboardController _dashboardController =
      Get.find<DashboardController>(
    tag: CommonConstants.dashboardControllerTag,
  );
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _dashboardController.onInit();
    FirebaseDeepLinkService.initDynamicLinks();
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => AppDialogs.showExitAppDialogDialog(context),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(ImagesPath.appLogo),
          ),
          leadingWidth: 100,
          actions: [
            CartBadgeWidget(),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GoldRatesWidget(),
            Expanded(
              child: Obx(
                () => _currentDashboardTabIndex.value == 0
                    ? DashboardWidget(
                        dashboardController: _dashboardController,
                      )
                    : ProfileWidget(
                        profileController: _profileController,
                      ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: _currentDashboardTabIndex.value,
            onTap: (int index) => _currentDashboardTabIndex.value = index,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_rounded),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_rounded),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
