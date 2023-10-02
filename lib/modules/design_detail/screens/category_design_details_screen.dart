// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
// import 'package:nkm_nose_pins_llp/constants/route_constants.dart';
// import 'package:nkm_nose_pins_llp/custom_libs/spin_kit/spinning_lines.dart';
// import 'package:nkm_nose_pins_llp/modules/cart/controllers/cart_controller.dart';
// import 'package:nkm_nose_pins_llp/modules/cart/widgets/cart_badge_widget.dart';
// import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/category_design_details_controller.dart';
// import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart'
//     as design_cate_item_as;
// import 'package:nkm_nose_pins_llp/utils/ui/app_dialogs.dart';
// import 'package:nkm_nose_pins_llp/widgets/loading_widget.dart';
// import 'package:nkm_nose_pins_llp/widgets/something_went_wrong_widget.dart';
//
// class CategoryDesignDetailsScreen extends StatefulWidget {
//   const CategoryDesignDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CategoryDesignDetailsScreen> createState() =>
//       _CategoryDesignDetailsScreenState();
// }
//
// class _CategoryDesignDetailsScreenState
//     extends State<CategoryDesignDetailsScreen> {
//   late design_cate_item_as.Data cateDesignListItem;
//   late String goldKarat;
//   final CategoryDesignDetailsController _designDetailsController =
//       Get.put(CategoryDesignDetailsController());
//   final CartController _cartController = Get.find<CartController>();
//   final RxInt currentIndex = 0.obs;
//   final ScrollController _scrollController = ScrollController();
//   final RxDouble _scrollPosition = 0.0.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       setState(() {
//         _scrollPosition.value = _scrollController.offset;
//       });
//     });
//     Map<String, dynamic> tempArgu = Get.arguments as Map<String, dynamic>;
//     cateDesignListItem =
//         tempArgu[RouteConstants.designDetailsModel] as design_cate_item_as.Data;
//     goldKarat = tempArgu[RouteConstants.goldKarat] as String;
//     _designDetailsController.getCategoryDesignDetailsApiCall(
//       designId: cateDesignListItem.designId.toString(),
//       goldKarat: goldKarat,
//       designQty: 1,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Expanded(
//               child: Text(
//                 cateDesignListItem.designName,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.end,
//                 style: TextStyle(
//                   fontSize: Get.textTheme.titleLarge!.fontSize,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 ' ( ${cateDesignListItem.designWeight} )',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           CartBadgeWidget(),
//           const SizedBox(
//             width: 6,
//           ),
//         ],
//       ),
//       body: Obx(
//         () => _designDetailsController.isLoadingDetails.value
//             ? const LoadingWidget()
//             : _designDetailsController.errorStringWhileLoadingDetails.isEmpty &&
//                     _designDetailsController.designDetailsModel.value != null
//                 ? _getDetailsScreenWidget()
//                 : SomethingWentWrongWidget(
//                     errorTxt: _designDetailsController
//                         .errorStringWhileLoadingDetails.value,
//                     retryOnSomethingWentWrong: () => _designDetailsController
//                         .getCategoryDesignDetailsApiCall(
//                       designId: cateDesignListItem.designId.toString(),
//                       goldKarat: goldKarat,
//                       designQty: 1,
//                     ),
//                   ),
//       ),
//       floatingActionButton: Container(
//         margin: const EdgeInsets.only(bottom: 60),
//         child: FloatingActionButton(
//           child: Obx(
//             () => cateDesignListItem.isLoading.value
//                 ? const SpinKitSpinningLines(
//                   color: Colors.white,
//                 )
//                 : const Icon(
//                     Icons.share_rounded,
//                     color: Colors.white,
//                   ),
//           ),
//           onPressed: () {
//             if (cateDesignListItem.isLoading.value) return;
//             cateDesignListItem.shareImage(
//               goldKarat: goldKarat,
//             );
//           },
//         ),
//       ),
//       bottomSheet: Obx(
//         () => _designDetailsController.isLoadingDetails.value
//             ? const SizedBox()
//             : _designDetailsController
//                     .errorStringWhileLoadingDetails.value.isEmpty
//                 ? Card(
//                     margin: EdgeInsets.zero,
//                     color: Colors.grey.shade100,
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: IntrinsicHeight(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Card(
//                                 margin: const EdgeInsets.symmetric(
//                                   vertical: 12,
//                                   horizontal: 4,
//                                 ),
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     30,
//                                   ),
//                                 ),
//                                 child: InkWell(
//                                   onTap: () {
//                                     _cartController
//                                         .addToCartApiCall(
//                                       context: context,
//                                       designId: cateDesignListItem.designId
//                                           .toString(),
//                                       goldKarat: goldKarat,
//                                       designQty: 1,
//                                       needToRefreshCart: false,
//                                     )
//                                         .then((result) {
//                                       if (result) {
//                                         Get.offAndToNamed(AppRoutes.cartScreen);
//                                       }
//                                     });
//                                   },
//                                   highlightColor: Colors.transparent,
//                                   borderRadius: BorderRadius.circular(
//                                     30,
//                                   ),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 22.0,
//                                       vertical: 12,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       // color: Get.theme.primaryColor,
//                                       borderRadius: BorderRadius.circular(30),
//                                       border: Border.all(
//                                         color: Get.theme.primaryColor,
//                                         // Specify the color for the outline border
//                                         width: 1.0,
//                                         // Specify the width of the outline border
//                                         style: BorderStyle
//                                             .solid, // Specify the style of the outline border
//                                       ),
//                                     ),
//                                     child: Text(
//                                       'add_to_cart'.tr,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         letterSpacing: 1.1,
//                                         color: Get.theme.primaryColor,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: Card(
//                                 margin: const EdgeInsets.symmetric(
//                                   vertical: 12,
//                                   horizontal: 4,
//                                 ),
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     30,
//                                   ),
//                                 ),
//                                 child: InkWell(
//                                   onTap: () {
//                                     _cartController
//                                         .addToCartApiCall(
//                                       context: context,
//                                       designId: cateDesignListItem.designId
//                                           .toString(),
//                                       goldKarat: goldKarat,
//                                       designQty: 1,
//                                       needToRefreshCart: false,
//                                     )
//                                         .then((result) {
//                                       if (result) {
//                                         Get.offAndToNamed(AppRoutes.cartScreen);
//                                       }
//                                     });
//                                   },
//                                   highlightColor: Colors.transparent,
//                                   borderRadius: BorderRadius.circular(
//                                     30,
//                                   ),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 22.0,
//                                       vertical: 12,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Get.theme.primaryColor,
//                                       borderRadius: BorderRadius.circular(
//                                         30,
//                                       ),
//                                     ),
//                                     child: Text(
//                                       'buy_now'.tr,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         letterSpacing: 1.1,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : const SizedBox(),
//       ),
//     );
//   }
//
//   Widget _getDetailsScreenWidget() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 340,
//             width: Get.width,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 ListView.builder(
//                   controller: _scrollController,
//                   padding: EdgeInsets.zero,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _designDetailsController
//                       .designDetailsModel.value!.designImageFiles.length,
//                   itemBuilder: (ctx, index) => InkWell(
//                     onTap: () => Get.toNamed(
//                       AppRoutes.zoomableImageViewScreen,
//                       arguments: {
//                         RouteConstants.title: cateDesignListItem.designName,
//                         RouteConstants.imageUrl: _designDetailsController
//                             .designDetailsModel.value!.designImageFiles[index],
//                       },
//                     ),
//                     highlightColor: Colors.transparent,
//                     child: SizedBox(
//                       width: Get.width,
//                       child: CachedNetworkImage(
//                         imageUrl: _designDetailsController
//                             .designDetailsModel.value!.designImageFiles[index],
//                         fit: BoxFit.contain,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) =>  Center(
//                           child: SpinKitSpinningLines(
//                   color: Get.theme.primaryColor,
//                 ),
//                         ),
//                         errorWidget: (context, url, error) => const Icon(
//                           Icons.error,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Obx(
//                   () => currentIndex.value >= 1
//                       ? Positioned(
//                           left: 12,
//                           top: 0,
//                           bottom: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.arrow_back_ios_new_rounded,
//                               color: Get.theme.primaryColor,
//                             ),
//                             onPressed: () {
//                               try {
//                                 if (currentIndex > 0) {
//                                   currentIndex.value--;
//                                   _scrollController.animateTo(
//                                     _scrollPosition.value - Get.width,
//                                     duration: const Duration(milliseconds: 250),
//                                     curve: Curves.easeInOut,
//                                   );
//                                 }
//                               } catch (_) {}
//                             },
//                           ),
//                         )
//                       : const SizedBox(),
//                 ),
//                 Obx(
//                   () => _designDetailsController.designDetailsModel.value!
//                                   .designImageFiles.length -
//                               1 >
//                           currentIndex.value
//                       ? Positioned(
//                           right: 12,
//                           top: 0,
//                           bottom: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               color: Get.theme.primaryColor,
//                             ),
//                             onPressed: () {
//                               try {
//                                 if (currentIndex <
//                                     _designDetailsController.designDetailsModel
//                                             .value!.designImageFiles.length -
//                                         1) {
//                                   currentIndex.value++;
//                                   _scrollController.animateTo(
//                                     _scrollPosition.value + Get.width,
//                                     duration: const Duration(milliseconds: 200),
//                                     curve: Curves.easeInOut,
//                                   );
//                                 }
//                               } catch (_) {}
//                             },
//                           ),
//                         )
//                       : const SizedBox(),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () => Get.toNamed(
//                   AppRoutes.zoomableImageViewScreen,
//                   arguments: {
//                     RouteConstants.title: cateDesignListItem.designName,
//                     RouteConstants.imageUrl: _designDetailsController
//                         .designDetailsModel.value!.designImage,
//                   },
//                 ),
//                 highlightColor: Colors.transparent,
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2),
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: _designDetailsController
//                         .designDetailsModel.value!.designImage,
//                     fit: BoxFit.contain,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) =>  Center(
//                       child: SpinKitSpinningLines(
//                   color: Get.theme.primaryColor,
//                 ),
//                     ),
//                     errorWidget: (context, url, error) => const Icon(
//                       Icons.error,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 28,
//               ),
//               InkWell(
//                 onTap: () => Get.toNamed(
//                   AppRoutes.videoViewScreen,
//                   arguments: {
//                     RouteConstants.productListItemModel: cateDesignListItem,
//                     RouteConstants.designDetailsModel:
//                         _designDetailsController.designDetailsModel.value!,
//                     RouteConstants.goldKarat: goldKarat,
//                   },
//                 ),
//                 highlightColor: Colors.transparent,
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2),
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   child: Icon(
//                     Icons.play_circle,
//                     color: Get.theme.primaryColor,
//                     size: 34,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Card(
//             margin: const EdgeInsets.only(
//               top: 8,
//               bottom: 12,
//               left: 12,
//               right: 12,
//             ),
//             elevation: 3,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
//               child: Column(
//                 children: [
//                   IntrinsicHeight(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'quantity'.tr,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   AppDialogs.showNumberPicker(
//                                     context: context,
//                                     onValueSelected: (selectedNumber) {
//                                       _designDetailsController
//                                           .refreshCategoryDesignDetailsApiCall(
//                                         designId: cateDesignListItem.designId
//                                             .toString(),
//                                         goldKarat: goldKarat,
//                                         designQty: selectedNumber,
//                                       );
//                                     },
//                                   );
//                                 },
//                                 highlightColor: Colors.transparent,
//                                 borderRadius: BorderRadius.circular(30),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 4.0,
//                                     vertical: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     // color: Get.theme.primaryColor,
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(
//                                       color: Get.theme.primaryColor,
//                                       width: 1.0,
//                                       style: BorderStyle
//                                           .solid, // Specify the style of the outline border
//                                     ),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Obx(
//                                           () => Text(
//                                             '${_designDetailsController.designDetailsModel.value!.designQty}',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: Get.textTheme
//                                                   .titleMedium!.fontSize,
//                                               fontWeight: FontWeight.w600,
//                                               color: Get.theme.primaryColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Icon(
//                                           Icons.edit,
//                                           color: Colors.grey,
//                                           size: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Obx(
//                                 () => Text(
//                                   !_designDetailsController.designDetailsModel
//                                           .value!.isSNKPOrNkm.value
//                                       ? 'karat'.tr
//                                       : 'stamp'.tr,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         Get.textTheme.titleSmall!.fontSize,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               Text(
//                                 _designDetailsController
//                                     .designDetailsModel.value!.designCaret,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleMedium!.fontSize,
//                                   fontWeight: FontWeight.w600,
//                                   color: Get.theme.primaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'gold_rate_pr_gram'.tr,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               Obx(
//                                 () => Text(
//                                   '₹${_designDetailsController.designDetailsModel.value!.designRatePerGm}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         Get.textTheme.titleMedium!.fontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: Get.theme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   IntrinsicHeight(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'gold_price'.tr,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               Obx(
//                                 () => Text(
//                                   '₹${_designDetailsController.designDetailsModel.value!.designPrice}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         Get.textTheme.titleMedium!.fontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: Get.theme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'making_charge'.tr,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               Obx(
//                                 () => Text(
//                                   '₹${_designDetailsController.designDetailsModel.value!.designMakingCharge}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         Get.textTheme.titleMedium!.fontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: Get.theme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'total'.tr,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: Get.textTheme.titleSmall!.fontSize,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 1,
//                               ),
//                               Obx(
//                                 () => Text(
//                                   '₹${_designDetailsController.designDetailsModel.value!.designTotal}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         Get.textTheme.titleMedium!.fontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: Get.theme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 140,
//           ),
//         ],
//       ),
//     );
//   }
// }
