import 'package:get/get_rx/get_rx.dart';

class LanguageModel {
  final String languageName;
  final String languageCode;
  final String countryCode;
  late RxBool isSelected = false.obs;
  late String? flagUrl;

  LanguageModel({
    required this.languageName,
    required this.languageCode,
    required this.countryCode,
    required this.isSelected,
  });
}
