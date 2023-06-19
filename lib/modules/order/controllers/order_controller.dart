import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
import 'package:nkm_nose_pins_llp/modules/order/models/place_order_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class OrderController extends GetxController {
  final RxBool isLoadingOrder = true.obs;
  final RxString errorStringWhileLoadingOrder = ''.obs;
  late PlaceOrderModel placeOrderModel;

  @override
  void onInit() {
    super.onInit();
    placeOrderApiCall();
  }

  void placeOrderApiCall() async {
    try {
      isLoadingOrder.value = true;
      errorStringWhileLoadingOrder.value = '';
      placeOrderModel = await ApiImplementer.placeOrderApiCall();
      if (placeOrderModel.success) {
        Get.find<CartController>().getOrderTotalFromCartApi();
        isLoadingOrder.value = false;
        errorStringWhileLoadingOrder.value = '';
        return;
      }
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = placeOrderModel.message;
      return;
    } on DioException catch (dioError) {
      String errMsg = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = errMsg;
      return;
    } catch (error) {
      isLoadingOrder.value = false;
      errorStringWhileLoadingOrder.value = error.toString();
      return;
    }
  }
}
