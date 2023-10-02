import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/payment/models/place_order_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

enum PaymentMethod {
  qrScanner,
  online,
}

class PaymentController extends GetxController {
  final RxBool isLoadingOrder = true.obs;
  final RxString errorStringWhileLoadingOrder = ''.obs;
  late PlaceOrderModel placeOrderModel;

  Future<bool> placeOrderApiCall({
    required int paymentMode,
  }) async {
    try {
      isLoadingOrder.value = true;
      errorStringWhileLoadingOrder.value = '';
      placeOrderModel = await ApiImplementer.placeOrderApiCall(
        paymentMode: paymentMode,
      );
      if (placeOrderModel.success) {
        isLoadingOrder.value = false;
        errorStringWhileLoadingOrder.value = '';
        return true;
      }
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = placeOrderModel.message;
      return false;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = errMsg;
      return false;
    } catch (error) {
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = error.toString();
      return false;
    }
  }
}
