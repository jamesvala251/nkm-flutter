import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/custom_libs/add_to_cart_animation/add_to_cart_animation.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/controllers/design_article_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/widgets/design_article_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/no_data_found_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class DesignArticleScreen extends StatefulWidget {
  const DesignArticleScreen({super.key});

  @override
  State<DesignArticleScreen> createState() => _DesignArticleScreenState();
}

class _DesignArticleScreenState extends State<DesignArticleScreen> {
  final CartController _cartController = Get.find<CartController>();
  final DesignArticleController _designArticleController =
      Get.put(DesignArticleController());
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  late int designId;
  late String designName;
  late String goldCaret;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> argument = Get.arguments as Map<String, dynamic>;
    designId = argument[RouteConstants.designId] as int;
    designName = argument[RouteConstants.designName];
    goldCaret = argument[RouteConstants.goldKarat];
    _designArticleController.getCategoryArticleListApiCall(designId: designId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
        curve: Curves.easeInOut,
        duration: Duration(
          milliseconds: 600,
        ),
      ),
      height: 30,
      width: 30,
      opacity: 0.85,
      jumpAnimation: const JumpAnimationOptions(
        curve: Curves.easeIn,
      ),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      cartKey: cartKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(designName),
          actions: [
            Obx(
              () => _cartController.orderTotal.value > 0
                  ? Wrap(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 18,
                            left: 6,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '₹${_cartController.orderTotal.value.toStringAsFixed(0)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            CartBadgeWidget(
              key: cartKey,
              onBackResultCallBack: (result) {
                _designArticleController.getCategoryArticleListApiCall(
                    designId: designId);
              },
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Obx(
                () => _designArticleController.isLoadingArticleList.value
                    ? const LoadingWidget()
                    : _designArticleController
                            .errorStringWhileLoadingArticleList.isEmpty
                        ? _designArticleController.articleList.isNotEmpty &&
                                _designArticleController
                                        .designArticleListModel.data !=
                                    null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: CupertinoScrollbar(
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12.0,
                                          childAspectRatio: 0.8,
                                          mainAxisSpacing: 12.0,
                                        ),
                                        padding: const EdgeInsets.all(16.0),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: _designArticleController
                                            .articleList.length,
                                        itemBuilder: (ctx, index) =>
                                            DesignArticleWidget(
                                          onClick: listClick,
                                          designId: _designArticleController
                                              .designArticleListModel.data!.id,
                                          articleDetail:
                                              _designArticleController
                                                  .articleList[index],
                                          goldCaret: goldCaret,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : NoDataFoundWidget(
                                retryOn: () => _designArticleController
                                    .getCategoryArticleListApiCall(
                                        designId: designId),
                                infoTxt: _designArticleController
                                    .designArticleListModel.message,
                              )
                        : SomethingWentWrongWidget(
                            errorTxt: _designArticleController
                                .errorStringWhileLoadingArticleList.value,
                            retryOnSomethingWentWrong: () =>
                                _designArticleController
                                    .getCategoryArticleListApiCall(
                                        designId: designId),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customHorizontalDivider() => Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Get.theme.primaryColor,
              Get.theme.primaryColor,
              Get.theme.primaryColor,
              Get.theme.primaryColor,
              Colors.transparent
            ],
            stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
}
