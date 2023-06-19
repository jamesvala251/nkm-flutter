import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/login/controllers/login_controller.dart';
import 'package:nkm_nose_pins_llp/modules/login/widgets/mobile_no_widget.dart';
import 'package:nkm_nose_pins_llp/modules/login/widgets/verify_otp_widget.dart';

enum LoginEnum {
  mobileNoPage,
  verifyOtpPage,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MobileNoWidget(
            onPageChanged: onPageChanged,
            loginController: _loginController,
          ),
          VerifyOtpWidget(
            onPageChanged: onPageChanged,
            loginController: _loginController,
          ),
        ],
      ),
    );
  }

  void onPageChanged(LoginEnum loginEnum) {
    if (loginEnum == LoginEnum.mobileNoPage) {
      _pageController.animateToPage(
        0,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.linear,
      );
    } else if (loginEnum == LoginEnum.verifyOtpPage) {
      _pageController.animateToPage(
        1,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.linear,
      );
    }
  }
}
