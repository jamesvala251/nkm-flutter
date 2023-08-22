import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/cart/screens/cart_screen.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/screens/category_design_list_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/screens/listing_image_view_screen.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/screens/refund_article_filter_screen.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/screens/refund_article_list_screen.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/screens/sub_category_design_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/update_app_screen.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/screens/video_view_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/zoomable_image_view_screen.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/screens/design_article_screen.dart';
import 'package:nkm_nose_pins_llp/modules/language/screens/select_language_screen.dart';
import 'package:nkm_nose_pins_llp/modules/login/screens/login_screen.dart';
import 'package:nkm_nose_pins_llp/modules/order/screens/order_details_screen.dart';
import 'package:nkm_nose_pins_llp/modules/order/screens/order_history_screen.dart';
import 'package:nkm_nose_pins_llp/modules/payment/screens/qr_scanner_payment_screen.dart';
import 'package:nkm_nose_pins_llp/modules/payment/screens/online_payment_screen.dart';
import 'package:nkm_nose_pins_llp/modules/profile/screens/update_profile_screen.dart';
import 'package:nkm_nose_pins_llp/modules/register/screens/register_screen.dart';

class AppScreens {
  static var list = [
    GetPage(
      name: AppRoutes.registerScreen,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.subCategoryDesignScreen,
      page: () => const SubCategoryDesignScreen(),
    ),
    GetPage(
      name: AppRoutes.categoryDesignListScreen,
      page: () => const CategoryDesignListScreen(),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: AppRoutes.qrScannerPaymentScreen,
      page: () => const QrScannerPaymentScreen(),
    ),
    GetPage(
      name: AppRoutes.onlinePaymentScreen,
      page: () => const OnlinePaymentScreen(),
    ),
    GetPage(
      name: AppRoutes.orderHistoryScreen,
      page: () => const OrderHistoryScreen(),
    ),
    GetPage(
      name: AppRoutes.orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.zoomableImageViewScreen,
      page: () => const ZoomableImageViewScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.categoryDesignDetailsScreen,
    //   page: () => const CategoryDesignDetailsScreen(),
    // ),
    GetPage(
      name: AppRoutes.designArticleScreen,
      page: () => const DesignArticleScreen(),
    ),
    GetPage(
      name: AppRoutes.videoViewScreen,
      page: () => const VideoViewScreen(),
    ),
    GetPage(
      name: AppRoutes.listingImageViewScreen,
      page: () => const ListingImageViewScreen(),
    ),
    GetPage(
      name: AppRoutes.languageScreen,
      page: () => const SelectLanguagesScreen(),
    ),
    GetPage(
      name: AppRoutes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.updateAppScreen,
      page: () => UpdateAppScreen(),
    ),
    GetPage(
      name: AppRoutes.refundArticleListScreen,
      page: () => const RefundArticleListScreen(),
    ),
    GetPage(
      name: AppRoutes.refundArticleFilterScreen,
      page: () => const RefundArticleFilterScreen(),
    ),
  ];
}
