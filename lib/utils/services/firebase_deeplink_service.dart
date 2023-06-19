import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart'
    as design_list_item_model;

class FirebaseDeepLinkService {
  static Future<void> initDynamicLinks() async {
    try {
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        print('From Firebase Dynamic Link Listen Method');
        final Uri deepLink = dynamicLinkData.link;
        _handleDeepLink(dynamicLinkUrl: deepLink.toString());
        return;
      }).onError((_) {
        print('Error:: From Firebase Dynamic Link Listen Method');
        return;
      });

      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = initialLink?.link;
      if (deepLink != null) {
        print('From PendingDynamicLinkData Method');
        _handleDeepLink(dynamicLinkUrl: deepLink.toString());
        return;
      }
      return;
    } catch (_) {
      print('Error:: From Firebase Init Dynamic Link Listen Method');
      return;
    }
  }

  static void _handleDeepLink({required String dynamicLinkUrl}) {
    try {
      final Uri deepLinkUri = Uri.parse(dynamicLinkUrl);
      Map<String, dynamic> receivedData = deepLinkUri.queryParameters;

      if (receivedData[CommonConstants.screenNameDynamicLinkKey]
              .toString()
              .trim()
              .toLowerCase() ==
          CommonConstants.screenNameDynamicLinkKey.trim().toLowerCase()) {
        print('GOING TO PRODUCT DETAILS SCREEN!!!!');
        design_list_item_model.Data designListItemModel =
            design_list_item_model.Data.fromJsonForDynamicLink(receivedData);
        String goldKarat =
            receivedData[CommonConstants.goldKaratDynamicLinkKey];
        Get.toNamed(
          AppRoutes.categoryDesignDetailsScreen,
          arguments: {
            ...designListItemModel.toJson(),
            RouteConstants.designDetailsModel: designListItemModel,
            RouteConstants.goldKarat: goldKarat.toString(),
          },
        );
        return;
      }
      print('DYNAMIC LINK DATA NOT MATCHED!');
      return;
    } catch (_) {
      print('Error:: From _handleDeepLink Method');
      return;
    }
  }

  static Future<String>
      createFirebaseShortDynamicLinkForProductDesignDetailsScreen({
    required design_list_item_model.Data designListItemModel,
    required String goldKarat,
  }) async {
    try {
      final Uri deepLink = Uri.parse("https://nkmnosepinsllp.com/").replace(
        queryParameters: {
          ...designListItemModel.toJson(),
          CommonConstants.goldKaratDynamicLinkKey: goldKarat,
          CommonConstants.screenNameDynamicLinkKey:
              CommonConstants.screenNameDynamicLinkKey,
        },
      );
      final dynamicLinkParams = DynamicLinkParameters(
        link: deepLink,
        uriPrefix: "https://nkmnosepinllp.page.link",
        androidParameters: const AndroidParameters(
          packageName: "com.org.nkm_nose_pins_llp",
        ),
        iosParameters: const IOSParameters(
          bundleId: "com.org.nkm_nose_pins_llp",
        ),
      );
      final ShortDynamicLink shortDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
      print(
          'SHORT FIREBASE DYNAMIC LINK GENERATED!${shortDynamicLink.shortUrl}');
      return shortDynamicLink.shortUrl.toString();
    } catch (err) {
      print('Error:: From GENERATING SHORT DYNAMIC LINK:: $err');
      return '';
    }
  }
}
