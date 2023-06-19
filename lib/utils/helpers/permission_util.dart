import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/custom_exception.dart';
import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> hasStoragePermission({
    required bool isAndroidVersion13OrAbove,
  }) async {
    try {
      if (!isAndroidVersion13OrAbove) {
        PermissionStatus storagePermissionStatus =
            await Permission.storage.status;
        if (storagePermissionStatus.isGranted) {
          return true;
        } else if (storagePermissionStatus.isDenied) {
          if (await Permission.storage.request().isGranted) {
            return true;
          }
        }
        throw CustomException(
          errMessage: 'storage_permission_err'.tr,
        );
      } else {
        PermissionStatus android13PhotosPermissionStatus =
            await Permission.photos.status;
        if (android13PhotosPermissionStatus.isGranted) {
          return true;
        } else if (android13PhotosPermissionStatus.isDenied) {
          if (await Permission.photos.request().isGranted) {
            PermissionStatus android13VideosPermissionStatus =
                await Permission.videos.status;
            if (android13VideosPermissionStatus.isGranted) {
              return true;
            } else if (android13VideosPermissionStatus.isDenied) {
              if (await Permission.videos.request().isGranted) {
                return true;
              }
            }
          }
        }
        throw CustomException(
          errMessage: 'storage_permission_err'.tr,
        );
      }
    } catch (e) {
      throw CustomException(
        errMessage: e.toString(),
      );
    }
  }

  static Future<bool> hasCameraPermission() async {
    try {
      PermissionStatus cameraPermissionStatus = await Permission.camera.status;
      if (cameraPermissionStatus.isGranted) {
        return true;
      } else if (cameraPermissionStatus.isDenied) {
        if (await Permission.camera.request().isGranted) {
          return true;
        }
        AppDialogs.showAlertDialog(
          context: Get.context!,
          title: 'Permission Required-1',
          description:
              'Please allow permission to access camera. Click on below button to open settings and allow permission .',
          firstButtonName: 'OPEN SETTINGS',
          secondButtonName: 'Cancel',
          onFirstButtonClicked: () async {
            Get.back();
            if (await openAppSettings()) {
              return;
            }
            AppDialogs.showInformationDialogue(
              context: Get.context!,
              description:
                  'You have to manually allow camera permission by going to  QRbot App Info -> Permissions -> Camera -> Allow only while using the app to use this feature!',
              onOkBntClick: () => Get.back(),
            );
            return;
          },
          onSecondButtonClicked: () => Get.back(),
        );
        return false;
      } else if (cameraPermissionStatus.isPermanentlyDenied) {
        AppDialogs.showAlertDialog(
          context: Get.context!,
          title: 'Permission Required-2',
          description:
              'Please allow permission to access camera. Click on below button to open settings and allow permission .',
          firstButtonName: 'OPEN SETTINGS',
          secondButtonName: 'Cancel',
          onFirstButtonClicked: () => openAppSettings(),
          onSecondButtonClicked: () => Get.back(),
        );
        return false;
      }
      return false;
    } catch (error) {
      AppDialogs.showAlertDialog(
        context: Get.context!,
        title: 'Error Occurred!-3',
        description: error.toString(),
        firstButtonName: 'Ok',
        secondButtonName: 'Cancel',
        onFirstButtonClicked: () => Get.back(),
        onSecondButtonClicked: () => Get.back(),
      );
      return false;
    }
  }
}
