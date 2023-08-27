// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
// import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_details_model.dart'
//     as designDetails;
// import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
// import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';
//
// class CategoryDesignDetailsController extends GetxController {
//   final RxBool isLoadingDetails = true.obs;
//   final RxString errorStringWhileLoadingDetails = ''.obs;
//   final Rx<designDetails.Data?> designDetailsModel =
//       Rx<designDetails.Data?>(null);
//
//   void getCategoryDesignDetailsApiCall({
//     required String designId,
//     required String goldKarat,
//     required int designQty,
//   }) async {
//     try {
//       designDetailsModel.value = null;
//       isLoadingDetails.value = true;
//       errorStringWhileLoadingDetails.value = '';
//       designDetails.DesignDetailsModel tempDesignDetailsModel =
//           await ApiImplementer.getDesignDetailsApiCall(
//         designId: designId,
//         goldKarat: goldKarat,
//         designQty: designQty,
//       );
//       if (tempDesignDetailsModel.success) {
//         designDetailsModel.value = tempDesignDetailsModel.data;
//         isLoadingDetails.value = false;
//         errorStringWhileLoadingDetails.value = '';
//         return;
//       }
//       isLoadingDetails.value = false;
//       errorStringWhileLoadingDetails.value = tempDesignDetailsModel.message;
//       return;
//     } on DioException catch (dioError) {
//       errorStringWhileLoadingDetails.value = Helper.getErrMsgFromDioError(
//         dioError: dioError,
//       );
//       isLoadingDetails.value = false;
//     } catch (error) {
//       errorStringWhileLoadingDetails.value = error.toString();
//       isLoadingDetails.value = false;
//     }
//   }
//
//   void refreshCategoryDesignDetailsApiCall({
//     required String designId,
//     required String goldKarat,
//     required int designQty,
//   }) async {
//     try {
//       designDetails.DesignDetailsModel tempDesignDetailsModelNew =
//           await ApiImplementer.getDesignDetailsApiCall(
//         designId: designId,
//         goldKarat: goldKarat,
//         designQty: designQty,
//       );
//       if (tempDesignDetailsModelNew.success) {
//         designDetailsModel.value = tempDesignDetailsModelNew.data;
//         return;
//       }
//       UiUtils.errorSnackBar(message: tempDesignDetailsModelNew.message);
//     } on DioException catch (dioError) {
//       String errValue = Helper.getErrMsgFromDioError(
//         dioError: dioError,
//       );
//       UiUtils.errorSnackBar(message: errValue);
//       return;
//     } catch (error) {
//       UiUtils.errorSnackBar(message: error.toString());
//       return;
//     }
//   }
// }
