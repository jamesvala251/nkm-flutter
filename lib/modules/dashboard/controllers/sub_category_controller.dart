import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_sub_category_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class SubCategoryController extends GetxController {
  final RxBool isLoadingSubCateDesign = true.obs;
  final RxString errorStringWhileLoadingSubCate = ''.obs;
  late DesignSubCategoryModel designSubCategoryModel;

  void getSubCategoryDesignApiCall({
    required String goldCaret,
    required String categoryId,
  }) async {
    try {
      isLoadingSubCateDesign.value = true;
      errorStringWhileLoadingSubCate.value = '';
      designSubCategoryModel = await ApiImplementer.getDesignSubCategoryApiCall(
        goldCaret: goldCaret,
        categoryId: categoryId,
      );
      if (designSubCategoryModel.success) {
        isLoadingSubCateDesign.value = false;
        errorStringWhileLoadingSubCate.value = '';
        return;
      }
      isLoadingSubCateDesign.value = false;
      errorStringWhileLoadingSubCate.value = designSubCategoryModel.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingSubCate.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingSubCateDesign.value = false;
    } catch (error) {
      errorStringWhileLoadingSubCate.value = error.toString();
      isLoadingSubCateDesign.value = false;
    }
  }
}
