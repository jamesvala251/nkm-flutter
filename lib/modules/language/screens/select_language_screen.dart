import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/custom_libs/animated_theme_switcher/animated_theme_switcher.dart';
import 'package:nkm_nose_pins_llp/modules/language/controllers/language_controller.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class SelectLanguagesScreen extends StatefulWidget {
  const SelectLanguagesScreen({Key? key}) : super(key: key);

  @override
  State<SelectLanguagesScreen> createState() => _SelectLanguagesScreenState();
}

class _SelectLanguagesScreenState extends State<SelectLanguagesScreen> {
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('select_language'.tr),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Obx(
          () => _languageController.isLoading.value
              ? const LoadingWidget()
              : _languageController.hasError.value
                  ? SomethingWentWrongWidget(
                      retryOnSomethingWentWrong: () =>
                          _languageController.prepareLanguageData(),
                      errorTxt: _languageController.errString,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Scrollbar(
                            thickness: 6.0,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 12.0,
                                childAspectRatio: 2,
                              ),
                              itemCount:
                                  _languageController.languageModelList.length,
                              primary: true,
                              itemBuilder: (ctx, index) => Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    _checkLanguage(index: index);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  leading: Obx(
                                    () => Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: _languageController
                                            .languageModelList[index]
                                            .isSelected
                                            .value,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (bool? value) {
                                          _checkLanguage(index: index);
                                        },
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _languageController
                                        .languageModelList[index].languageName,
                                  ),
                                  subtitle: Text(
                                    '${_languageController.languageModelList[index].languageName} (${_languageController.languageModelList[index].countryCode.toUpperCase()})',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // ApplovinAdsProvider.of.showApplovinBannerAds()
                      ],
                    ),
        ),
      ),
    );
  }

  void _checkLanguage({
    required int index,
  }) async {
    try {
      _languageController.languageModelList
          .firstWhere((element) => element.isSelected.value)
          .isSelected
          .value = false;
      _languageController.languageModelList[index].isSelected.value = true;
      await Get.updateLocale(
        Locale(
          _languageController.languageModelList[index].languageCode
              .toLowerCase(),
          _languageController.languageModelList[index].countryCode
              .toUpperCase(),
        ),
      );
      await PreferenceObj.setLanguageCode(
        languageCode: _languageController.languageModelList[index].languageCode
            .toLowerCase()
            .trim(),
      );
      await PreferenceObj.setCountryCode(
        countryCode: _languageController.languageModelList[index].countryCode
            .toUpperCase()
            .trim(),
      );
    } catch (error) {
      UiUtils.errorSnackBar(message: '$error');
    }
  }
}
