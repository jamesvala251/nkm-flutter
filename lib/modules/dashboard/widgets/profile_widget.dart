import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/modules/profile/controllers/profile_controller.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';

class ProfileWidget extends StatelessWidget {
  final ProfileController profileController;

  const ProfileWidget({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(
        () => profileController.isProfileLoading.value
            ? const LoadingWidget()
            : profileController.errorStringWhileLoadingProfile.isEmpty
                ? _getUserProfileWidget(
                    context: context,
                  )
                : SomethingWentWrongWidget(
                    errorTxt: profileController
                        .errorStringWhileLoadingProfile.value,
                    retryOnSomethingWentWrong: () {
                      profileController.getUserProfileApiCall();
                    },
                  ),
      ),
    );
  }

  Widget _getUserProfileWidget({
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Adjust the border radius as desired
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: CircleAvatar(
                              child: Text(
                                profileController.getUserProfileModel!.data!
                                    .profileCircleName,
                                style: TextStyle(
                                  fontSize: Get.textTheme.titleLarge!.fontSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                profileController
                                    .getUserProfileModel!.data!.name,
                                style: TextStyle(
                                  fontSize: Get.textTheme.titleLarge!.fontSize,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: Get.textTheme.titleSmall!.fontSize,
                                    color: Get.theme.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    profileController
                                        .getUserProfileModel!.data!.userType,
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleSmall!.fontSize,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone_android_rounded,
                                    size: Get.textTheme.titleSmall!.fontSize,
                                    color: Get.theme.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    '+91 ${profileController.getUserProfileModel!.data!.mobileNo}',
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.titleSmall!.fontSize,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.email_rounded,
                        size: Get.textTheme.titleSmall!.fontSize,
                        color: Get.theme.primaryColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        profileController.getUserProfileModel!.data!.email,
                        style: TextStyle(
                          fontSize: Get.textTheme.titleSmall!.fontSize,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Adjust the border radius as desired
            ),
            child: InkWell(
              onTap: () => Get.toNamed(AppRoutes.updateProfileScreen)!.then(
                (value) {
                  profileController.getUserProfileApiCall();
                },
              ),
              borderRadius: BorderRadius.circular(8),
              highlightColor: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'edit_profile'.tr,
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Get.theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Adjust the border radius as desired
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.orderHistoryScreen);
              },
              borderRadius: BorderRadius.circular(8),
              highlightColor: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'order_history'.tr,
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Get.theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Adjust the border radius as desired
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.languageScreen);
              },
              borderRadius: BorderRadius.circular(8),
              highlightColor: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.language_rounded,
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'change_language'.tr,
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Get.theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: InkWell(
              onTap: () {
                AppDialogs.showLogoutDialogue(
                  context: context,
                  onCancelBtnClick: () => Get.back(),
                  onLogoutBtnClick: () {
                    Get.back();
                    profileController.logoutApiCall(
                      context: context,
                    );
                  },
                );
              },
              borderRadius: BorderRadius.circular(8),
              highlightColor: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'logout'.tr,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Obx(
            () => Text(
              profileController.versionName.value,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
