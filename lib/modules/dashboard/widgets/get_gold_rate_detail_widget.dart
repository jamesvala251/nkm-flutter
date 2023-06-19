import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';

class GetGoldRateDetailWidget extends StatefulWidget {
  const GetGoldRateDetailWidget({super.key});

  @override
  State<GetGoldRateDetailWidget> createState() =>
      _GetGoldRateDetailWidgetState();
}

class _GetGoldRateDetailWidgetState extends State<GetGoldRateDetailWidget>
    with TickerProviderStateMixin {
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  //for 14K animation
  late AnimationController _animation14KController;
  Animation<double>? _animation14K;

  //for 18K animation
  late AnimationController _animation18KController;
  Animation<double>? _animation18K;

  //for 24K animation
  late AnimationController _animation24KController;
  Animation<double>? _animation24K;

  double universalAnimationDurationFactor =
      1; // Adjust this value to control the animation speed

  @override
  void initState() {
    super.initState();
    configureAndStart14kAnimation();
    configureAndStart18kAnimation();
    configureAndStart24kAnimation();
  }

  @override
  void dispose() {
    _animation14KController.dispose();
    _animation18KController.dispose();
    _animation24KController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 8,
      ),
      elevation: 4,
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            child: Text(
                              '14K',
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
                            child: AnimatedBuilder(
                              animation: _animation14KController,
                              builder: (BuildContext context, Widget? child) {
                                return Text(
                                  '₹${_animation14K?.value.toStringAsFixed(0) ?? ''}',
                                  style: TextStyle(
                                    fontSize:
                                        Get.textTheme.titleSmall!.fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFE998),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      indent: 2,
                      endIndent: 2,
                      color: Color(0xFFFFE998),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              '18K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Get.textTheme.titleSmall!.fontSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFFE998),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          FittedBox(
                            child: AnimatedBuilder(
                              animation: _animation18KController,
                              builder: (BuildContext context, Widget? child) {
                                return Text(
                                  '₹${_animation18K?.value.toStringAsFixed(0) ?? ''}',
                                  style: TextStyle(
                                    fontSize:
                                    Get.textTheme.titleSmall!.fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFE998),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      indent: 2,
                      endIndent: 2,
                      color: Color(0xFFFFE998),
                    ),
                    // Expanded(
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       FittedBox(
                    //         child: Text(
                    //           '20K',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: Get.textTheme.titleSmall!.fontSize,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 1,
                    //       ),
                    //       FittedBox(
                    //         child: Text(
                    //           '₹${dashboardController.goldRatesModel!.data!.s20k}',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: Get.textTheme.titleSmall!.fontSize,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // VerticalDivider(
                    //   width: 1,
                    //   indent: 2,
                    //   endIndent: 2,
                    //   color: Get.theme.primaryColor,
                    // ),
                    // Expanded(
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       FittedBox(
                    //         child: Text(
                    //           '22K',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: Get.textTheme.titleSmall!.fontSize,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 1,
                    //       ),
                    //       FittedBox(
                    //         child: Text(
                    //           '₹${dashboardController.goldRatesModel!.data!.s22k}',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: Get.textTheme.titleSmall!.fontSize,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // VerticalDivider(
                    //   width: 1,
                    //   indent: 2,
                    //   endIndent: 2,
                    //   color: Get.theme.primaryColor,
                    // ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              '24K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Get.textTheme.titleSmall!.fontSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFFE998),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          FittedBox(
                            child: AnimatedBuilder(
                              animation: _animation24KController,
                              builder: (BuildContext context, Widget? child) {
                                return Text(
                                  '₹${_animation24K?.value.toStringAsFixed(0) ?? ''}',
                                  style: TextStyle(
                                    fontSize:
                                    Get.textTheme.titleSmall!.fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFE998),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void configureAndStart14kAnimation() {
    _animation14KController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(
          milliseconds: 50000,)
    );

    // Create a custom curve using the Interval and CurvedAnimation
    final curve = CurvedAnimation(
      parent: _animation14KController,
      curve: const Interval(
        0.0,
        0.3, // Adjust this value to control the slowing down effect
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _animation14K = Tween<double>(
            begin: double.parse(
                    dashboardController.goldRatesModel!.data!.anim14k) -
                20,
            end:
                double.parse(dashboardController.goldRatesModel!.data!.anim14k))
        .animate(curve);
    _animation14KController.forward();
  }

  void configureAndStart18kAnimation() {
    _animation18KController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(
          milliseconds:50000,)
    );

    // Create a custom curve using the Interval and CurvedAnimation
    final curve = CurvedAnimation(
      parent: _animation18KController,
      curve: const Interval(
        0.0,
        0.3, // Adjust this value to control the slowing down effect
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _animation18K = Tween<double>(
            begin: double.parse(
                    dashboardController.goldRatesModel!.data!.anim18k) -
                20,
            end:
                double.parse(dashboardController.goldRatesModel!.data!.anim18k))
        .animate(curve);
    _animation18KController.forward();
  }

  void configureAndStart24kAnimation() {
    _animation24KController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(
          milliseconds: 50000,)
    );

    // Create a custom curve using the Interval and CurvedAnimation
    final curve = CurvedAnimation(
      parent: _animation24KController,
      curve: const Interval(
        0.0,
        0.3, // Adjust this value to control the slowing down effect
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _animation24K = Tween<double>(
            begin: double.parse(
                    dashboardController.goldRatesModel!.data!.anim24k) -
                20,
            end:
                double.parse(dashboardController.goldRatesModel!.data!.anim24k))
        .animate(curve);
    _animation24KController.forward();
  }
}
