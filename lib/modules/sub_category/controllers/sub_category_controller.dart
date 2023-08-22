import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/sub_category/models/design_sub_category_model.dart'
    as design_sub_cate;
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class SubCategoryController extends GetxController {
  final RxBool isLoadingSubCateDesign = true.obs;
  final RxString errorStringWhileLoadingSubCate = ''.obs;
  final RxList<design_sub_cate.Data> subCategoryList =
      RxList<design_sub_cate.Data>([]);

  void getSubCategoryDesignApiCall({
    required String goldCaret,
    required String categoryId,
  }) async {
    try {
      isLoadingSubCateDesign.value = true;
      errorStringWhileLoadingSubCate.value = '';
      design_sub_cate.DesignSubCategoryModel tempDesignSubCategoryModel =
          await ApiImplementer.getDesignSubCategoryApiCall(
        goldCaret: goldCaret,
        categoryId: categoryId,
      );
      if (tempDesignSubCategoryModel.success) {
        isLoadingSubCateDesign.value = false;
        errorStringWhileLoadingSubCate.value = '';
        subCategoryList.value = tempDesignSubCategoryModel.data;
        return;
      }
      isLoadingSubCateDesign.value = false;
      errorStringWhileLoadingSubCate.value = tempDesignSubCategoryModel.message;
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

  void refreshSubCategoryApiCall({
    required String goldCaret,
    required String categoryId,
  }) async {
    try {
      design_sub_cate.DesignSubCategoryModel tempDesignSubCategoryModel =
          await ApiImplementer.getDesignSubCategoryApiCall(
        goldCaret: goldCaret,
        categoryId: categoryId,
      );
      if (tempDesignSubCategoryModel.success) {
        subCategoryList.value = tempDesignSubCategoryModel.data;
        return;
      }
    } catch (_) {}
  }
}
