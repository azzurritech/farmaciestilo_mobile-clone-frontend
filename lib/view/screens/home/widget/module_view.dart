import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/banner_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/custom_loader.dart';
import 'package:farmacie_stilo/view/base/title_widget.dart';
import 'package:farmacie_stilo/view/screens/address/widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/view/screens/home/widget/banner_view.dart';
import 'package:farmacie_stilo/view/screens/home/widget/popular_store_view.dart';

class ModuleView extends StatelessWidget {
  final SplashController splashController;
  const ModuleView({Key? key, required this.splashController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<BannerController>(builder: (bannerController) {
        return const BannerView(isFeatured: true);
      }),
      splashController.moduleList != null
          ? splashController.moduleList!.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Dimensions.paddingSizeSmall,
                    crossAxisSpacing: Dimensions.paddingSizeSmall,
                    childAspectRatio: (1 / 1),
                  ),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  itemCount: splashController.moduleList!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => splashController.switchModule(index, true),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 700 : 200]!,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall),
                                child: CustomImage(
                                  image:
                                      '${splashController.configModel!.baseUrls!.moduleImageUrl}/${splashController.moduleList![index].icon}',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Center(
                                  child: Text(
                                splashController.moduleList![index].moduleName!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall),
                              )),
                            ]),
                      ),
                    );
                  },
                )
              : Center(
                  child: Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text('no_module_found'.tr),
                ))
          : ModuleShimmer(isEnabled: splashController.moduleList == null),
      const SizedBox(height: Dimensions.paddingSizeLarge),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: TitleWidget(title: 'deliver_to'.tr),
      ),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      GetBuilder<LocationController>(builder: (locationController) {
        List<AddressModel?> addressList = [];
        if (Get.find<AuthController>().isLoggedIn() &&
            locationController.addressList != null) {
          addressList = [];
          bool contain = false;
          if (locationController.getUserAddress()!.id != null) {
            for (int index = 0;
                index < locationController.addressList!.length;
                index++) {
              if (locationController.addressList![index].id ==
                  locationController.getUserAddress()!.id) {
                contain = true;
                break;
              }
            }
          }
          if (!contain) {
            addressList.add(Get.find<LocationController>().getUserAddress());
          }
          addressList.addAll(locationController.addressList!);
        } else {
          addressList.add(Get.find<LocationController>().getUserAddress());
        }
        return (!Get.find<AuthController>().isLoggedIn() ||
                locationController.addressList != null)
            ? SizedBox(
                height: 70,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: addressList.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300,
                      padding: const EdgeInsets.only(
                          right: Dimensions.paddingSizeSmall),
                      child: AddressWidget(
                        address: addressList[index],
                        fromAddress: false,
                        onTap: () {
                          if (locationController.getUserAddress()!.id !=
                              addressList[index]!.id) {
                            Get.dialog(const CustomLoader(),
                                barrierDismissible: false);
                            locationController.saveAddressAndNavigate(
                              addressList[index],
                              false,
                              null,
                              false,
                              ResponsiveHelper.isDesktop(context),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              )
            : AddressShimmer(
                isEnabled: Get.find<AuthController>().isLoggedIn() &&
                    locationController.addressList == null);
      }),
      const PopularStoreView(isPopular: false, isFeatured: true),
      const SizedBox(height: 30),
    ]);
  }
}

class ModuleShimmer extends StatelessWidget {
  final bool isEnabled;
  const ModuleShimmer({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: Dimensions.paddingSizeSmall,
        crossAxisSpacing: Dimensions.paddingSizeSmall,
        childAspectRatio: (1 / 1),
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[Get.isDarkMode ? 700 : 200]!,
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: isEnabled,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Colors.grey[300]),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Center(
                  child: Container(
                      height: 15, width: 50, color: Colors.grey[300])),
            ]),
          ),
        );
      },
    );
  }
}

class AddressShimmer extends StatelessWidget {
  final bool isEnabled;
  const AddressShimmer({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)
                  ? Dimensions.paddingSizeDefault
                  : Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                      blurRadius: 5,
                      spreadRadius: 1)
                ],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(
                  Icons.location_on,
                  size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    enabled: isEnabled,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 15, width: 100, color: Colors.grey[300]),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Container(
                              height: 10, width: 150, color: Colors.grey[300]),
                        ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}