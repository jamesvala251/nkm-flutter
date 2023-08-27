import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_category_model.dart'
    as design_cate_model;
import 'package:nkm_nose_pins_llp/modules/dashboard/models/gold_rates_model.dart'
    as gold_rate_model;
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class DashboardController extends GetxController {
  final RxBool isLoadingGoldRates = true.obs;
  final RxString goldRateErrorString = ''.obs;
  final RxList<gold_rate_model.GoldRate> goldRateList =
      RxList<gold_rate_model.GoldRate>([]);
  final RxList<gold_rate_model.GoldCategory> goldRateCategoryList =
      RxList<gold_rate_model.GoldCategory>([]);
  final RxInt selectedKarat = 0.obs;

  final RxBool isLoadingDesignCategory = true.obs;
  final RxString errorStringWhileLoadingDesignCategory = ''.obs;
  final RxList<design_cate_model.Data> categoryList =
      RxList<design_cate_model.Data>([]);

  late bool _isInitApiCalled = false;

  @override
  void onInit() {
    super.onInit();
    if (_isInitApiCalled) {
      return;
    }
    _isInitApiCalled = true;
    getGoldRatesApiCall();
    return;
  }

  void getGoldRatesApiCall() async {
    try {
      goldRateList.clear();
      goldRateCategoryList.clear();
      isLoadingGoldRates.value = true;
      goldRateErrorString.value = '';
      gold_rate_model.GoldRatesModel tempGoldRateModel =
          await ApiImplementer.getGoldRatesApiCall();
      if (tempGoldRateModel.success) {
        goldRateList.value = tempGoldRateModel.data.goldRate;
        if (tempGoldRateModel.data.goldCategory.isEmpty) {
          isLoadingGoldRates.value = false;
          goldRateErrorString.value = '';
          return;
        }
        goldRateCategoryList.value = tempGoldRateModel.data.goldCategory;
        gold_rate_model.GoldCategory firstGoldRateCategory =
            goldRateCategoryList.first;
        firstGoldRateCategory.isSelected.value = true;
        selectedKarat.value = firstGoldRateCategory.value;
        getDesignCategoryApiCallNew(
          goldCaret: selectedKarat.value,
        );
        isLoadingGoldRates.value = false;
        goldRateErrorString.value = '';
        return;
      }
      isLoadingGoldRates.value = false;
      goldRateErrorString.value = tempGoldRateModel.message;
      return;
    } on DioException catch (dioError) {
      goldRateErrorString.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingGoldRates.value = false;
      return;
    } catch (error) {
      goldRateErrorString.value = error.toString();
      isLoadingGoldRates.value = false;
      return;
    }
  }

  void getDesignCategoryApiCallNew({
    required int goldCaret,
  }) async {
    try {
      categoryList.clear();
      isLoadingDesignCategory.value = true;
      errorStringWhileLoadingDesignCategory.value = '';
      design_cate_model.DesignCategoryModel tempDesignCategoryModel =
          await ApiImplementer.getDesignCategoryApiCall(
        goldCaret: goldCaret.toString(),
      );
      if (tempDesignCategoryModel.success) {
        categoryList.value = tempDesignCategoryModel.data;
        isLoadingDesignCategory.value = false;
        errorStringWhileLoadingDesignCategory.value = '';
        return;
      }
      isLoadingDesignCategory.value = false;
      errorStringWhileLoadingDesignCategory.value =
          tempDesignCategoryModel.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingDesignCategory.value =
          Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingDesignCategory.value = false;
      return;
    } catch (error) {
      errorStringWhileLoadingDesignCategory.value = error.toString();
      isLoadingDesignCategory.value = false;
      return;
    }
  }
}
