import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/refund_article/controllers/filter_refund_article_controller.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class FilterRefundArticleBottomSheetWidget extends StatelessWidget {
  final TextEditingController _articleNoController = TextEditingController();

  final FilterRefundArticleController _filterRefundArticleController =
      Get.find<FilterRefundArticleController>();

  FilterRefundArticleBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _articleNoController.text =
        _filterRefundArticleController.articleNumber.value == -1
            ? ''
            : _filterRefundArticleController.articleNumber.value.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'apply_filters'.tr,
                  style: TextStyle(
                    fontSize: Get.textTheme.titleLarge!.fontSize!,
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                splashRadius: 12,
                icon: const Icon(
                  Icons.close_rounded,
                ),
                color: Get.theme.primaryColor,
              )
            ],
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Get.theme.primaryColor,
                  Get.theme.primaryColor,
                  Get.theme.primaryColor,
                  Get.theme.primaryColor,
                  Colors.transparent
                ],
                stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  ...getArticleSeriesNumberTextFieldWidget(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _getFilterButtons(),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getArticleSeriesNumberTextFieldWidget() {
    return [
      TextFormField(
        cursorColor: Get.theme.primaryColor,
        controller: _articleNoController,
        textInputAction: TextInputAction.done,
        maxLength: 15,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          color: Get.theme.primaryColor,
          fontSize: Get.textTheme.titleMedium!.fontSize,
        ),
        decoration: InputDecoration(
          prefixText: 'NK',
          prefixStyle: TextStyle(
            fontSize: Get.textTheme.titleMedium!.fontSize,
          ),
          prefixIcon: Icon(
            Icons.numbers_rounded,
            color: Get.theme.primaryColor,
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 12.0),
          label: Text(
            'article_number_new'.tr,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: Get.textTheme.titleLarge!.fontSize,
            ),
          ),
          labelStyle: TextStyle(
            letterSpacing: 1.1,
            color: Get.theme.primaryColor,
          ),
          hintText: 'enter_article_no'.tr,
          hintStyle: TextStyle(
            letterSpacing: 1.1,
            color: Colors.grey.shade600,
          ),
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 1.8,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 1.8,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.8,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.8,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),
    ];
  }

  Widget _getFilterButtons() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
            onPressed: () {
              _articleNoController.clear();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'clear'.tr,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          flex: 6,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () => _applyFilter(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'apply_filter'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.textTheme.titleMedium!.fontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _applyFilter() {
    try {
      _filterRefundArticleController.articleNumber.value =
          _articleNoController.text.trim().isEmpty
              ? -1
              : int.parse(_articleNoController.text.trim());
      _filterRefundArticleController.getRefundArticleListApiCall();

      if (_articleNoController.text.trim().isEmpty) {
        _filterRefundArticleController.isFilterApplied.value = false;
        Get.back(result: true);
        return;
      }

      _filterRefundArticleController.isFilterApplied.value = true;
      Get.back(result: true);
      return;
    } catch (err) {
      UiUtils.errorSnackBar(message: err.toString());
      return;
    }
  }
}
