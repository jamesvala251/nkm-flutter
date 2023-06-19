import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/dashboard_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/gold_rates_widget.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/widgets/profile_widget.dart';
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
      Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
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
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       const SizedBox(
        //         height: 30.0,
        //       ),
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: SizedBox(
        //           height: 100,
        //           width: 100,
        //           child: Card(
        //             margin: EdgeInsets.zero,
        //             elevation: 4,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(60),
        //             ),
        //             child: CircleAvatar(
        //               child: Text(
        //                 "VR",
        //                 style: TextStyle(
        //                   fontSize: Get.textTheme.titleLarge!.fontSize,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.home),
        //         title: const Text('Home'),
        //         onTap: () {
        //           // Handle the tap on Home
        //         },
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.settings),
        //         title: const Text('Settings'),
        //         onTap: () {
        //           // Handle the tap on Settings
        //         },
        //       ),
        //       // Add more ListTiles for additional drawer options
        //     ],
        //   ),
        // ),
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
                    : ProfileWidget(dashboardController: _dashboardController),
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
                icon: const Icon(Icons.person_rounded),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
