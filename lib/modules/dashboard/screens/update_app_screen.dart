import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/images_path.dart';
import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateAppScreen extends StatelessWidget {
  late Map<String, dynamic> argumentMap;

  UpdateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    argumentMap = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Expanded(
              child: Image(
                image: AssetImage(ImagesPath.updateAppAnimation),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'we_are_better_than_ever'.tr,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      'we_added_lots_of_new_features_fix_some_bugs'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () {
                        StoreRedirect.redirect(
                          androidAppId: argumentMap[RouteConstants.packageName],
                          iOSAppId:
                              "REPLACE_WITH_APP_ID_BEFORE_PUBLISHING_TO_APP_STORE",
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'update_app'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (argumentMap[RouteConstants.severity] ==
                        CommonConstants.appUpdateSeverityOptionUpdate) ...[
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'not_now'.tr,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
