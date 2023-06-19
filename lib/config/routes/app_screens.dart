import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/cart/screens/cart_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/category_design_details_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/category_design_list_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/sub_category_design_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/video_view_screen.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/screens/zoomable_image_view_screen.dart';
import 'package:nkm_nose_pins_llp/modules/language/screens/select_language_screen.dart';
import 'package:nkm_nose_pins_llp/modules/login/screens/login_screen.dart';
import 'package:nkm_nose_pins_llp/modules/order/screens/order_details_screen.dart';
import 'package:nkm_nose_pins_llp/modules/order/screens/order_history_screen.dart';
import 'package:nkm_nose_pins_llp/modules/order/screens/order_response_screen.dart';
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
      name: AppRoutes.orderResponseScreen,
      page: () => const OrderResponseScreen(),
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
    GetPage(
      name: AppRoutes.categoryDesignDetailsScreen,
      page: () => const CategoryDesignDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.videoViewScreen,
      page: () => const VideoViewScreen(),
    ),
    GetPage(
      name: AppRoutes.languageScreen,
      page: () => const SelectLanguagesScreen(),
    ),
    GetPage(
      name: AppRoutes.updateProfileScreen,
      page: () =>  const UpdateProfileScreen(),
    ),
  ];
}
