import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';

void showCartSnackBar(BuildContext context) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    dismissDirection: DismissDirection.horizontal,
    margin: EdgeInsets.only(
      right: ResponsiveHelper.isDesktop(context)
          ? context.width * 0.7
          : Dimensions.paddingSizeSmall,
      top: Dimensions.paddingSizeSmall,
      bottom: Dimensions.paddingSizeSmall,
      left: Dimensions.paddingSizeSmall,
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: Color(0xffFCDDD3),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
    content: Text('item_added_to_cart'.tr,
        style: robotoMedium.copyWith(color: Colors.white)),
    action: SnackBarAction(
        label: 'view_cart'.tr,
        onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
        textColor: Colors.white),
  ));
  // Get.showSnackbar(GetSnackBar(
  //   backgroundColor: Colors.green,
  //   message: 'item_added_to_cart'.tr,
  //   mainButton: TextButton(
  //     onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
  //     child: Text('view_cart'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor)),
  //   ),
  //   onTap: (_) => Get.toNamed(RouteHelper.getCartRoute()),
  //   duration: Duration(seconds: 3),
  //   maxWidth: Dimensions.WEB_MAX_WIDTH,
  //   snackStyle: SnackStyle.FLOATING,
  //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
  //   borderRadius: 10,
  //   isDismissible: true,
  //   dismissDirection: DismissDirection.horizontal,
  // ));
}
