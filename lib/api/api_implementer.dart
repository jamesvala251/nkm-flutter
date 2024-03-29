import 'package:dio/dio.dart';
import 'package:nkm_nose_pins_llp/api/auth_token_dio_client.dart';
import 'package:nkm_nose_pins_llp/api/dio_client.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/add_design_to_cart_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/decrease_qty_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/get_user_cart_item_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/increase_qty_model.dart';
import 'package:nkm_nose_pins_llp/modules/cart/models/remove_design_from_cart_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_category_model.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/models/design_list_model.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_list_model.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/models/refund_article_model.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/models/design_sub_category_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/get_user_profile_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/gold_rates_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/logout_model.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/version_info_model.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/models/design_article_model.dart';
import 'package:nkm_nose_pins_llp/modules/payment/models/get_order_payment_status_model.dart';
import 'package:nkm_nose_pins_llp/modules/profile/models/update_user_profile_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/models/get_otp_model.dart';
import 'package:nkm_nose_pins_llp/modules/login/models/user_login_model.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_details_model.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/order_history_model.dart';
import 'package:nkm_nose_pins_llp/modules/payment/models/place_order_model.dart';
import 'package:nkm_nose_pins_llp/modules/register/models/register_model.dart';

class ApiImplementer {
  static const String _authRoutePrefix = 'auth';
  static const String _nkmRoutePrefix = 'nkm';
  static const String _userRoutePrefix = 'user';

  static Future<VersionInfoModel> versionInfoApiCall() async {
    try {
      final response = await DioClient.getDioClient()!.get(
        'version-info',
        queryParameters: {
          "type": CommonConstants.loginTypeUser,
        },
      );
      return VersionInfoModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<GetOtpModel> getOtpApiCall({
    required String mobileNo,
  }) async {
    try {
      final response = await DioClient.getDioClient()!.post(
        '$_authRoutePrefix/get-otp',
        data: {
          "mobile_no": mobileNo,
          "type": "login",
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return GetOtpModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<UserLoginModel> loginApiCall({
    required String mobileNo,
    required String otp,
  }) async {
    try {
      final response = await DioClient.getDioClient()!.post(
        '$_authRoutePrefix/user-login',
        data: {
          "mobile_no": mobileNo,
          "otp": otp,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return UserLoginModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<RegisterUserModel> registerUserApiCall({
    required String name,
    required String shopName,
    required String email,
    required String mobileNo,
    required String pinCode,
    required String role,
    required String panNo,
    required String gstNo,
  }) async {
    try {
      final response = await DioClient.getDioClient()!.post(
        '$_authRoutePrefix/registration',
        data: {
          'name': name,
          'shop_name': shopName,
          'email': email,
          'mobile_no': mobileNo,
          'pincode': pinCode,
          'role': role,
          'pan_no': panNo,
          'gst_no': gstNo
        },
      );
      return RegisterUserModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<GoldRatesModel> getGoldRatesApiCall() async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/gold-rates',
      );
      return GoldRatesModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<DesignCategoryModel> getDesignCategoryApiCall({
    required String goldCaret,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/design-category-list',
        data: {
          "gold_caret": goldCaret,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return DesignCategoryModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<DesignSubCategoryModel> getDesignSubCategoryApiCall({
    required String goldCaret,
    required String categoryId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/design-sub-category-list',
        data: {
          "gold_caret": goldCaret,
          "category_id": categoryId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return DesignSubCategoryModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<DesignListModel> getDesignListApiCall({
    required String goldCaret,
    required String subCategoryId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/design-list',
        data: {
          "gold_caret": goldCaret,
          "sub_category_id": subCategoryId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return DesignListModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<LogoutModel> logoutApiCall() async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/user-logout',
      );
      return LogoutModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  // static Future<DesignDetailsModel> getDesignDetailsApiCall({
  //   required String designId,
  //   required String goldKarat,
  //   required int designQty,
  // }) async {
  //   try {
  //     final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
  //       '$_nkmRoutePrefix/design-details',
  //       data: {
  //         "design_id": designId,
  //         "gold_caret": goldKarat,
  //         "design_qty": designQty,
  //       },
  //       options: Options(
  //         headers: CommonConstants.applicationJsonHeader,
  //       ),
  //     );
  //     return DesignDetailsModel.fromJson(response.data);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  //Cart

  static Future<AddDesignToCartModel> addDesignToCartApiCall({
    required int designId,
    required int caretId,
    required int articleId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/add-to-cart',
        data: {
          "design_id": designId,
          "caret_id": caretId,
          "article_id": articleId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return AddDesignToCartModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<RemoveDesignFromCartModel> removeDesignFromCartApiCall({
    required int itemId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/remove-to-cart',
        data: {
          "item_id": itemId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return RemoveDesignFromCartModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<IncreaseQuantityModel> increaseQtyApiCall({
    required int userCartId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/increase-qty',
        data: {
          "user_cart_id": userCartId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return IncreaseQuantityModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<DecreaseQuantityModel> decreaseQtyApiCall({
    required int userCartId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/decrease-qty',
        data: {
          "user_cart_id": userCartId,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return DecreaseQuantityModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<GetUserCartItemsModel> getCartApiCall() async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/user-cart-items',
      );
      return GetUserCartItemsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  //Orders
  static Future<PlaceOrderModel> placeOrderApiCall({
    required int paymentMode,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/place-order',
        data: {
          'payment_mode': paymentMode,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return PlaceOrderModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<GetOrderPaymentStatus> getOrderPaymentStatusApiCall({
    required String orderNo,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/order-payment-status',
        queryParameters: {
          'order_no': orderNo,
        },
      );
      return GetOrderPaymentStatus.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<OrderHistoryModel> getOrderHistoryApiCall({
    required int pageNo,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/my-order-history',
        queryParameters: {
          'page': pageNo,
        },
      );
      return OrderHistoryModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<OrderDetailsModel> getOrderDetailsApiCall({
    required int orderId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/my-order-details',
        queryParameters: {
          'order_id': orderId,
        },
      );
      return OrderDetailsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  //Profile
  static Future<GetUserProfileModel> getUseProfileApiCall() async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_userRoutePrefix/profile',
      );
      return GetUserProfileModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<UpdateUserProfileModel> updateUserProfileApiCall({
    required String name,
    required String panNo,
    required String gstNo,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_userRoutePrefix/profile',
        data: {
          "name": name,
          "pan_no": panNo,
          "gst_no": gstNo,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return UpdateUserProfileModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> updateFcmTokenApiCall({
    required String fcmToken,
  }) async {
    try {
      await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_userRoutePrefix/profile',
        data: {
          "fcm_token": fcmToken,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return;
    } catch (error) {
      rethrow;
    }
  }

  static Future<DesignArticleModel> getDesignArticleApiCall({
    required int designId,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/design-article-detail',
        queryParameters: {
          "design_id": designId,
        },
      );
      return DesignArticleModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<RefundArticleListModel> getRefundArticleListApiCall({
    required int page,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/get-refund-article',
        queryParameters: {
          "page": page,
        },
      );
      return RefundArticleListModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<RefundArticleListModel> getFilteredRefundArticleListApiCall({
    required int page,
    required int articleNumber,
  }) async {
    try {
      Map<String, dynamic> reqParams = {
        "page": page,
      };

      if (articleNumber != -1) {
        reqParams.putIfAbsent("article_number", () => articleNumber);
      }

      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.get(
        '$_nkmRoutePrefix/get-refund-article',
        queryParameters: reqParams,
      );
      return RefundArticleListModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<RefundArticleModel> refundArticleApiCall({
    required int articleNumber,
  }) async {
    try {
      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/article-refund',
        data: {
          "article_number": articleNumber,
        },
        options: Options(
          headers: CommonConstants.applicationJsonHeader,
        ),
      );
      return RefundArticleModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> deactivateUser({
    required bool isDeactivate,
  }) async {
    try {
      Map<String, dynamic> reqParams = {
        'deactivate_profile': isDeactivate ? 1 : 0,
      };

      final response = await AuthTokenDioClient.getAuthTokenDioClient()!.post(
        '$_nkmRoutePrefix/deactivate-user',
        data: reqParams,
      );
      return;
    } catch (error) {
      rethrow;
    }
  }
}
