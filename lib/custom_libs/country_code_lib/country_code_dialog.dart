import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_data.dart';
import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryCodeDialog extends StatefulWidget {
  final Function onCountrySelected;
  const CountryCodeDialog({required this.onCountrySelected, Key? key}) : super(key: key);

  @override
  State<CountryCodeDialog> createState() => _CountryCodeDialogState();
}

class _CountryCodeDialogState extends State<CountryCodeDialog> {
  final RxBool _isEmpty = true.obs;
  final _searchCountryTextEditingController = TextEditingController();
  final RxList<CountryCodeModel> tempCountryCodeModelList =
      RxList<CountryCodeModel>([]);

  @override
  void initState() {
    tempCountryCodeModelList.value = CountryCodeData.countryCodeModelList;
    _searchCountryTextEditingController.addListener(() {
      if (_searchCountryTextEditingController.text.isEmpty) {
        _isEmpty.value = true;
      } else {
        _isEmpty.value = false;
      }
      onTextSearching(
        _searchCountryTextEditingController.text.trim(),
      );
    });
    super.initState();
  }

  void onTextSearching(String query) {
    if (query.isNotEmpty) {
      tempCountryCodeModelList.value =
          CountryCodeData.countryCodeModelList.where((element) {
        return (element.name + element.dialCode)
            .trim()
            .toLowerCase()
            .contains(query.trim().toLowerCase());
      }).toList();
    } else if (query.isEmpty) {
      tempCountryCodeModelList.value = CountryCodeData.countryCodeModelList;
    }
  }

  @override
  void dispose() {
    _searchCountryTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _searchCountryTextEditingController,
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: Get.textTheme.titleMedium!.fontSize,
          ),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'search'.tr,
            prefixIcon: Icon(
              Icons.search,
              color: Get.theme.primaryColor,
            ),
            suffixIcon: Obx(
              () => _isEmpty.value
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        _searchCountryTextEditingController.text = "";
                      },
                      child: Icon(
                        Icons.close,
                        color: Get.theme.primaryColor,
                      ),
                    ),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: _getCountryCodeListWidget(),
        ),
      ],
    );
  }

  Widget _getCountryCodeListWidget() {
    return Obx(
      () => tempCountryCodeModelList.isNotEmpty
          ? Scrollbar(
              child: ListView.builder(
                itemCount: tempCountryCodeModelList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      widget.onCountrySelected(tempCountryCodeModelList[index]);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            tempCountryCodeModelList[index].flagUri,
                            height: 32.0,
                            width: 32.0,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Text(
                              tempCountryCodeModelList[index].name,
                              style: TextStyle(
                                fontSize: Get.textTheme.subtitle1!.fontSize,
                              ),
                            ),
                          ),
                          Text(tempCountryCodeModelList[index].dialCode),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No result found for "${_searchCountryTextEditingController.text.trim()}"',
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
