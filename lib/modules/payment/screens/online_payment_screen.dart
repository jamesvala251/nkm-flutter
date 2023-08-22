import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/payment/controllers/payment_controller.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_failed_widget.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_loading_widget.dart';
import 'package:nkm_nose_pins_llp/modules/payment/widgets/payment_success_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum PaymentStatusEnum {
  processing,
  success,
  failed,
}

class OnlinePaymentScreen extends StatefulWidget {
  const OnlinePaymentScreen({super.key});

  @override
  State<OnlinePaymentScreen> createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  final PaymentController _paymentController = Get.put(PaymentController());
  late final WebViewController _webViewController;
  final RxBool _isWebViewLoading = true.obs;
  final RxBool _isPageLoading = false.obs;
  late bool _backResult = false;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              _isWebViewLoading.value = false;
              return;
            }
          },
          onPageStarted: (String url) {
            _isPageLoading.value = true;
          },
          onUrlChange: (currentUrl) {
            if (currentUrl.url != null &&
                currentUrl.url!.isNotEmpty &&
                currentUrl.url!.trim().toLowerCase().contains(_paymentController
                    .placeOrderModel.cancelUrl
                    .trim()
                    .toLowerCase())) {
              _backResult = false;
              Get.back(result: _backResult);
              _webViewController.setNavigationDelegate(NavigationDelegate());
              // _paymentStatus.value = PaymentStatusEnum.failed;
              return;
            }
          },
          onPageFinished: (String currentUrl) {
            _isPageLoading.value = false;
            if (currentUrl != null &&
                currentUrl.toString().isNotEmpty &&
                currentUrl.toString().trim().toLowerCase().contains(
                    _paymentController.placeOrderModel.redirectUrl
                        .trim()
                        .toLowerCase())) {
              _backResult = true;
              _webViewController.setNavigationDelegate(NavigationDelegate());
              _webViewRedirectDelay();
              // _paymentStatus.value = PaymentStatusEnum.success;
              return;
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    _paymentController
        .placeOrderApiCall(
      paymentMode: CommonConstants.paymentModeOnline,
    )
        .then((value) {
      if (value) {
        _webViewController.loadRequest(
          Uri.parse(_paymentController.placeOrderModel.paymentUrl),
        );
      }
    });
  }

  void _webViewRedirectDelay() {
    Future.delayed(
      const Duration(seconds: 4),
    ).then((value) {
      Get.back(result: _backResult);
      return;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_paymentController.isLoadingOrder.value) {
          return Future.value(false);
        }
        Get.back(result: _backResult);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('payment_screen'.tr),
        ),
        body: Obx(
          () => _paymentController.isLoadingOrder.value
              ? const PaymentLoadingWidget()
              : _paymentController.errorStringWhileLoadingOrder.isEmpty
                  ? _buildPaymentWebViewWidget()
                  : SomethingWentWrongWidget(
                      retryOnSomethingWentWrong: () {
                        _paymentController.placeOrderApiCall(
                          paymentMode: CommonConstants.paymentModeOnline,
                        );
                      },
                      errorTxt:
                          _paymentController.errorStringWhileLoadingOrder.value,
                    ),
        ),
      ),
    );
  }

  Widget _buildPaymentWebViewWidget() {
    print("_buildPaymentWebViewWidget() Called");
    return Obx(
      () => _isWebViewLoading.value
          ? const PaymentLoadingWidget()
          : Stack(
              children: [
                WebViewWidget(controller: _webViewController),
                Obx(
                  () => _isPageLoading.value
                      ? LinearProgressIndicator(
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Get.theme.primaryColor,
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
    );
  }
}
