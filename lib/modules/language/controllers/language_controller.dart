import 'dart:io';

import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/language/models/language_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';

class LanguageController extends GetxController {
  late RxBool isLoading = true.obs;
  late RxBool hasError = false.obs;
  late String errString = '';
  late RxList<LanguageModel> languageModelList = RxList<LanguageModel>([]);

  @override
  void onInit() {
    super.onInit();
    prepareLanguageData();
  }

  void prepareLanguageData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errString = '';
      languageModelList.clear();
      languageModelList.add(
        LanguageModel(
          languageName: 'English',
          languageCode: 'en',
          countryCode: 'US',
          isSelected: false.obs,
        ),
      );
      languageModelList.add(
        LanguageModel(
          languageName: 'हिन्दी',
          languageCode: 'hi',
          countryCode: 'IN',
          isSelected: false.obs,
        ),
      );
      // languageModelList.add(
      //   LanguageModel(
      //     languageName: 'ગુજરાતી',
      //     languageCode: 'gu',
      //     countryCode: 'IN',
      //     isSelected: false.obs,
      //   ),
      // );
      String? selectedLanguageCode = PreferenceObj.getLanguageCode;
      if (selectedLanguageCode != null) {
        languageModelList
            .firstWhere(
                (element) => element.languageCode == selectedLanguageCode)
            .isSelected
            .value = true;
      } else {
        var systemLanguageLocal = Platform.localeName;
        String systemLanguageCode = systemLanguageLocal.substring(0, 2);
        String systemCountryCode = systemLanguageLocal.substring(3, 5);
        int index = languageModelList.indexWhere((element) =>
            element.languageCode == systemLanguageCode &&
            element.countryCode == systemCountryCode);
        if (index != -1) {
          languageModelList[index].isSelected.value = true;
        } else {
          languageModelList.first.isSelected.value = true;
        }
      }
      isLoading.value = false;
      hasError.value = false;
      errString = '';
    } catch (error) {
      errString = error.toString();
      isLoading.value = false;
      hasError.value = true;
    }
  }
}
