import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiUtils {
  static dynamic notifyUserSnackBar({
    required String message,
  }) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor:Colors.black,
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 14.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  static dynamic errorSnackBar({
    required String message,
  }) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade600,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 14.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  static dynamic successSnackBar({
    required String message,
  }) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade600,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 14.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

// static SnackbarController showAlertSnackBar({
//   required String heading,
//   required String message,
// }) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(heading, message,
//       colorText: Colors.white,
//       backgroundColor: Colors.grey.withOpacity(0.6),
//       icon: const Icon(
//         Icons.warning_amber,
//         color: Colors.white,
//       ),
//       duration: const Duration(seconds: 1));
// }

//
// static SnackbarController successSnackBar({
//   String title = 'Success',
//   String message = "",
// }) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(
//     title,
//     message,
//     icon: Wrap(
//       children: [
//         Card(
//           elevation: 2.0,
//           margin: const EdgeInsets.all(8.0),
//           color: Colors.green,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.all(4.0),
//             child: Icon(Icons.check_circle, size: 32.0, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     snackPosition: SnackPosition.TOP,
//     margin: const EdgeInsets.all(20),
//     backgroundColor: Colors.green.shade50,
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
//     borderWidth: 1.0,
//     borderRadius: 12.0,
//   );
// }
//
// static SnackbarController errorSnackBar({
//   String title = 'Error',
//   String message = "",
// }) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(
//     title,
//     message,
//     icon: Wrap(
//       children: [
//         Card(
//           elevation: 2.0,
//           margin: const EdgeInsets.all(8.0),
//           color: Colors.red,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.all(4.0),
//             child:
//                 Icon(Icons.warning_rounded, size: 32.0, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     snackPosition: SnackPosition.TOP,
//     margin: const EdgeInsets.all(20),
//     backgroundColor: Colors.red.shade50,
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
//     borderWidth: 1.0,
//     borderRadius: 12.0,
//   );
// }
//

// static SnackbarController alertSnackBar({
//   String title = 'Alert',
//   String? message,
// }) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(
//     title,
//     message ?? "",
//     icon: Wrap(
//       children: [
//         Card(
//           elevation: 2.0,
//           margin: const EdgeInsets.all(8.0),
//           color: Colors.red,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.all(4.0),
//             child: Icon(Icons.notifications_on_rounded,
//                 size: 32.0, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     snackPosition: SnackPosition.TOP,
//     margin: const EdgeInsets.all(20),
//     backgroundColor: Colors.red.shade50,
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
//     borderWidth: 1.0,
//     borderRadius: 12.0,
//   );
// }

// static SnackbarController buttonSnackBar({
//   String title = 'Success',
//   String message = "",
//   required String buttonText,
//   required VoidCallback buttonOnPressed,
// }) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(
//     title,
//     message,
//     icon: Wrap(
//       children: [
//         Card(
//           elevation: 2.0,
//           margin: const EdgeInsets.all(8.0),
//           color: Colors.green,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.all(4.0),
//             child: Icon(Icons.check_circle, size: 32.0, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     mainButton:
//         TextButton(onPressed: buttonOnPressed, child: Text(buttonText)),
//     snackPosition: SnackPosition.TOP,
//     margin: const EdgeInsets.all(20),
//     backgroundColor: Colors.green.shade50,
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
//     borderWidth: 1.0,
//     borderRadius: 12.0,
//   );
// }
//
// static SnackbarController demoSnackBar(
//     {String title = "Success", required String subTitle}) {
//   Get.closeAllSnackbars();
//   return Get.snackbar(title, subTitle,
//       icon: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             height: 70,
//             decoration: const BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             child: Transform(
//               alignment: Alignment.centerLeft,
//               transform: Matrix4.rotationX(math.pi),
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.only(bottomLeft: Radius.circular(12)),
//                 child: SvgPicture.asset(
//                   "assets/svg/bubbles.svg",
//                   height: 38,
//                   width: 30,
//                   color: Colors.green.shade800,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       snackPosition: SnackPosition.TOP,
//       margin: const EdgeInsets.all(20),
//       backgroundColor: Colors.green,
//       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//       borderRadius: 12.0,
//       colorText: Colors.white);
// }

// static SnackbarController actionPerformedSnackBar({
//   required String message,
// }) {
//   Get.closeAllSnackbars();
//   return Get.showSnackbar(
//     GetSnackBar(
//       duration: const Duration(seconds: 1),
//       message: message,
//       mainButton: TextButton(
//         onPressed: () {
//           Get.closeAllSnackbars();
//         },
//         child: Text(
//           "ok",
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: Get.textTheme.subtitle1!.fontSize),
//         ),
//       ),
//     ),
//   );
// }

//
// static SnackbarController notifyUserSnackBar({
//   required String message,
// }) {
//   Get.closeAllSnackbars();
//   return Get.showSnackbar(
//     GetSnackBar(
//       duration: const Duration(seconds: 3),
//       message: message,
//     ),
//   );
// }
}
