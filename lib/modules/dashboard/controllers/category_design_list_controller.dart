import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class CategoryDesignListController extends GetxController {
  final RxBool isLoadingCateDesignList = true.obs;
  final RxString errorStringWhileLoadingCateDesignList = ''.obs;
  late DesignListModel categoryDesignListModel;

  void getCategoryDesignListApiCall({
    required String goldCaret,
    required String subCategoryId,
  }) async {
    try {
      isLoadingCateDesignList.value = true;
      errorStringWhileLoadingCateDesignList.value = '';
      categoryDesignListModel = await ApiImplementer.getDesignListApiCall(
        goldCaret: goldCaret,
        subCategoryId: subCategoryId,
      );
      if (categoryDesignListModel.success) {
        isLoadingCateDesignList.value = false;
        errorStringWhileLoadingCateDesignList.value = '';
        return;
      }
      isLoadingCateDesignList.value = false;
      errorStringWhileLoadingCateDesignList.value =
          categoryDesignListModel.message;
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
}
