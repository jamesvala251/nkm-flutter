import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/controllers/design_article_controller.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/models/design_article_model.dart';

class DesignArticleWidget extends StatelessWidget {
  DesignArticleWidget({
    super.key,
    required this.designId,
    required this.articleDetail,
    required this.goldCaret,
    required this.onClick,
  });

  final DesignArticleController _designArticleController =
      Get.find<DesignArticleController>();
  late final int designId;
  late final String goldCaret;
  late final ArticleDetail articleDetail;
  final CartController _cartController = Get.find<CartController>();
  final GlobalKey widgetKey = GlobalKey();

  final void Function(GlobalKey) onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 4, bottom: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 6.0, left: 12.0, right: 12.0, bottom: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 6.0,
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: SizedBox(
                      width: Get.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            articleDetail.articalNumber,
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: Get.textTheme.titleMedium!.fontSize,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: _designArticleController
                        .designArticleListModel.data!.images.isNotEmpty
                    ? FittedBox(
                        child: CachedNetworkImage(
                          imageUrl: _designArticleController
                              .designArticleListModel.data!.images.first,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => FittedBox(
                            child: Image.asset(
                              ImagesPath.noImageAvailable,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        ImagesPath.noImageAvailable,
                        fit: BoxFit.contain,
                      ),
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "₹${articleDetail.totalPrice.toString()}",
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontSize: Get.textTheme.titleMedium!.fontSize,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "${articleDetail.weight}mg",
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontSize: Get.textTheme.titleMedium!.fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Get.width * 0.20,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(18.0),
                          onTap: () {
                            onClick(widgetKey);
                            _cartController
                                .addToCartApiCall(
                              context: context,
                              designId: designId,
                              articleId: articleDetail.id,
                              caretId: articleDetail.productCaretId,
                            )
                                .then((value) {
                              if (value != false) {
                                _designArticleController
                                    .refreshArticleListApiCall(
                                  articleId: articleDetail.id,
                                  designId: designId,
                                );
                              }
                            });
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
