import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_data.dart';
import 'package:nkm_nose_pins_llp/custom_libs/country_code_lib/country_code_model.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryCodeWidget extends StatelessWidget {
  final Rx<CountryCodeModel> _selectedCountryCodeModel = Rx<CountryCodeModel>(
    CountryCodeModel(
        code: 'IN',
        dialCode: '+91',
        name: 'India',
        flagUri: 'assets/png/flags/in.png',
        currencyCode: "INR",
        currencySymbol: "₹"),
  );
  final Function onCountrySelected;
  final String initialDialCode;
  late Color textColor;
  final bool needToShowFlag;

  CountryCodeWidget({
    required this.onCountrySelected,
    required this.initialDialCode,
    required this.needToShowFlag,
    this.textColor = Colors.white70,
    Key? key,
  }) : super(key: key);

  void _onCountryChanged(CountryCodeModel selectedCountryCodeModel) {
    _selectedCountryCodeModel.value = selectedCountryCodeModel;
    onCountrySelected(_selectedCountryCodeModel.value);
  }

  @override
  Widget build(BuildContext context) {
    if (initialDialCode.isNotEmpty) {
      _selectedCountryCodeModel.value =
          CountryCodeData.countryCodeModelList.firstWhere(
        (element) => element.dialCode.trim() == initialDialCode.trim(),
      );
    }

    return InkWell(
      onTap: () {
        AppDialogs.showCountryPickerDialog(
          context: context,
          onCountrySelected: _onCountryChanged,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (needToShowFlag) ...[
            Obx(
              () => Image.asset(
                _selectedCountryCodeModel.value.flagUri,
                height: 24.0,
                width: 24.0,
              ),
            ),
            const SizedBox(
              width: 2.0,
            ),
          ],
          Obx(
            () => Text(
              ' ${_selectedCountryCodeModel.value.dialCode} ',
              style: TextStyle(
                fontSize: Get.textTheme.titleMedium!.fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
