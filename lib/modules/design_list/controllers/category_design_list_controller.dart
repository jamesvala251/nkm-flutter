import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/design_list/models/design_list_model.dart'
    as design_list;
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class CategoryDesignListController extends GetxController {
  final RxBool isLoadingCateDesignList = true.obs;
  final RxString errorStringWhileLoadingCateDesignList = ''.obs;
  final RxList<design_list.Data> designList = RxList<design_list.Data>([]);

  void getSubCategoryDesignListApiCall({
    required String goldCaret,
    required String subCategoryId,
  }) async {
    try {
      isLoadingCateDesignList.value = true;
      errorStringWhileLoadingCateDesignList.value = '';
      design_list.DesignListModel tempCategoryDesignListModel =
          await ApiImplementer.getDesignListApiCall(
        goldCaret: goldCaret,
        subCategoryId: subCategoryId,
      );
      if (tempCategoryDesignListModel.success) {
        isLoadingCateDesignList.value = false;
        errorStringWhileLoadingCateDesignList.value = '';
        designList.value = tempCategoryDesignListModel.data;
        return;
      }
      isLoadingCateDesignList.value = false;
      errorStringWhileLoadingCateDesignList.value =
          tempCategoryDesignListModel.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingCateDesignList.value =
          Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingCateDesignList.value = false;
    } catch (error) {
      errorStringWhileLoadingCateDesignList.value = error.toString();
      isLoadingCateDesignList.value = false;
    }
  }

  void refreshSubCategoryDesignList({
    required String goldCaret,
    required String subCategoryId,
  }) async {
    try {
      design_list.DesignListModel tempCategoryDesignListModel =
          await ApiImplementer.getDesignListApiCall(
        goldCaret: goldCaret,
        subCategoryId: subCategoryId,
      );
      if (tempCategoryDesignListModel.success) {
        designList.value = tempCategoryDesignListModel.data;
        return;
      }
    } catch (_) {}
  }
}
