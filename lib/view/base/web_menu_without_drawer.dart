import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/cart_controller.dart';
import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/screens/location/access_location_screen.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/text_hover.dart';

class WebMenuBarWithout extends StatefulWidget implements PreferredSizeWidget {
  const WebMenuBarWithout({Key? key}) : super(key: key);

  @override
  State<WebMenuBarWithout> createState() => _WebMenuBarWithoutState();

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 70);
}

class _WebMenuBarWithoutState extends State<WebMenuBarWithout> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: Dimensions.webMaxWidth,
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Center(
          child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Row(children: [
                InkWell(
                  onTap: ((){
                    Get.find<AuthController>().clearSharedAddress();
                    Get.to( AccessLocationScreen(
              fromSignUp: Get.parameters['page'] == "/sign-up",
              fromHome: Get.parameters['page'] == 'home',
              route: null,
            ));
                  }),
                  // onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
                  child: Image.asset(Images.logo, width: 100),
                ),
                Get.find<LocationController>().getUserAddress() != null
                    ? Expanded(
                        child: InkWell(
                        onTap: () => Get.toNamed(
                            RouteHelper.getAccessLocationRoute('home')),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: GetBuilder<LocationController>(
                              builder: (locationController) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Icon(
                                //   locationController
                                //               .getUserAddress()!
                                //               .addressType ==
                                //           'home'
                                //       ? Icons.home_filled
                                //       : locationController
                                //                   .getUserAddress()!
                                //                   .addressType ==
                                //               'office'
                                //           ? Icons.work
                                //           : Icons.location_on,
                                //   size: 20,
                                //   color: Theme.of(context)
                                //       .textTheme
                                //       .bodyLarge!
                                //       .color,
                                // ),
                                // const SizedBox(
                                //     width: Dimensions.paddingSizeExtraSmall),
                                // Flexible(
                                //   child: Text(
                                //     locationController
                                //         .getUserAddress()!
                                //         .address!,
                                //     style: robotoRegular.copyWith(
                                //       color: Theme.of(context)
                                //           .textTheme
                                //           .bodyLarge!
                                //           .color,
                                //       fontSize: Dimensions.fontSizeSmall,
                                //     ),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                // Icon(Icons.keyboard_arrow_down,
                                //     color: Theme.of(context).primaryColor),
                              ],
                            );
                          }),
                        ),
                      ))
                    : const Expanded(child: SizedBox()),
                const SizedBox(width: 20),
                Get.find<LocationController>().getUserAddress() == null
                    ? Row(children: [
                        MenuButton(
                            title: 'home'.tr,
                            onTap: () =>
                                Get.toNamed(RouteHelper.getInitialRoute())),
                        const SizedBox(width: 20),
                        MenuButton(
                            title: 'the'.tr,
                            onTap: () => 
                            Get.toNamed(
                                RouteHelper.getgrupo('group'))
                                ),
                                 const SizedBox(width: 20),
 MenuButton(
                            title: 'servicea'.tr,
                            onTap: () => 
                            Get.toNamed(
                                RouteHelper.getHtmlRoute('services'))
                                ),

   const SizedBox(width: 20),
 MenuButton(
                            title: 'shops'.tr,
                            onTap: () => 
                            Get.toNamed(
                                RouteHelper.getHtmlRoute('shops'))
                                ),


                        const SizedBox(width: 20),
                      
 MenuButton(
                            title: 'who'.tr,
                            onTap: () => Get.toNamed(
                                RouteHelper.getHtmlRoute('whoweare'))),
                        const SizedBox(width: 20),
                        // MenuButton(
                        //     title: 'privacy_policy'.tr,
                        //     onTap: () => Get.toNamed(
                        //         RouteHelper.getHtmlRoute('privacy-policy'))),
                      ])
                    : SizedBox(
                        // width: MediaQuery.of(context).size.width/4,
                        // child: GetBuilder<SearchControllers>(
                        //     builder: (searchController) {
                        //   _searchController.text =
                        //       searchController.searchHomeText!;
                        //   return SearchField(
                        //     controller: _searchController,
                        //     hint: Get.find<SplashController>()
                        //             .configModel!
                        //             .moduleConfig!
                        //             .module!
                        //             .showRestaurantText!
                        //         ? 'search_food_or_restaurant'.tr
                        //         : 'search_item_or_store'.tr,
                        //     suffixIcon:
                        //         searchController.searchHomeText!.isNotEmpty
                        //             ? Icons.highlight_remove
                        //             : Icons.search,
                        //     filledColor:
                        //         Theme.of(context).colorScheme.background,
                        //     iconPressed: () {
                        //       if (searchController.searchHomeText!.isNotEmpty) {
                        //         _searchController.text = '';
                        //         searchController.clearSearchHomeText();
                        //       } else {
                        //         searchData();
                        //       }
                        //     },
                        //     onSubmit: (text) => searchData(),
                        //   );
                        // })
                        ),
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.notifications,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getNotificationRoute())),
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.favorite,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getMainRoute('favourite'))),
                const SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.shopping_cart,
                    isCart: true,
                    onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
                const SizedBox(width: 20),
                GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                  int index0 = 0;
                  List<DropdownMenuItem<int>> languageList = [];
                  for (int index = 0;
                      index < AppConstants.languages.length;
                      index++) {
                    languageList.add(DropdownMenuItem(
                      value: index,
                      child: TextHover(builder: (hovered) {
                        return Row(children: [
                          Image.asset(AppConstants.languages[index].imageUrl!,
                              height: 20, width: 20),
                          const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall),
                          // Text(AppConstants.languages[index].languageName!,
                          //     style: robotoRegular.copyWith(
                          //         color: hovered
                          //             ? Color(0xff1c592d)
                          //             : null)),
                        ]);
                      }),
                    ));
                   
                      
                    if (AppConstants.languages[index].languageCode ==
                        localizationController.locale!.languageCode) {
                      index0 = index;
                    }
                  }
                  return DropdownButton<int>(
                    value: index0,
                    items: languageList,
                    dropdownColor: Theme.of(context).cardColor,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 0,
                    iconSize: 30,
                    underline: const SizedBox(),
                    onChanged: (int? index) {
         
     localizationController.setLanguage(Locale(
                          AppConstants.languages[index!].languageCode!,
                          AppConstants.languages[index].languageName));
               

                      
                 
                    },
                  );
                }),
                const SizedBox(width: 20),
                // MenuIconButton(
                  
                //     icon: Icons.menu,
                //     onTap: () {
                //       Scaffold.of(context).openEndDrawer();
                //     }),
                const SizedBox(width: 20),
                GetBuilder<AuthController>(builder: (authController) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(authController.isLoggedIn()
                          ? RouteHelper.getProfileRoute()
                          : RouteHelper.getSignInRoute(RouteHelper.main));
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: const Color(0xffA4A4A4),
                      ),
                      child: Row(children: [
                        Icon(
                            authController.isLoggedIn()
                                ? Icons.person_pin_rounded
                                : Icons.lock,
                            size: 20,
                            color: Colors.white),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        MenuButtons(title:   authController.isLoggedIn()
                                ? 'profile'.tr
                                : 'sign_in'.tr, )
                    //  b   Text(
                          
                    //         authController.isLoggedIn()
                    //             ? 'profile'.tr
                    //             : 'sign_in'.tr,
                    //         style: robotoRegular.copyWith(
                    //             fontSize: Dimensions.fontSizeLarge,
                    //             color: Colors.white)),
                      ]),
                    ),
                  );
                }),
              ]))),
    );
  }

  void searchData() {
    if (_searchController.text.trim().isEmpty) {
      showCustomSnackBar(Get.find<SplashController>()
              .configModel!
              .moduleConfig!
              .module!
              .showRestaurantText!
          ? 'search_food_or_restaurant'.tr
          : 'search_item_or_store'.tr);
    } else {
      Get.toNamed(
          RouteHelper.getSearchRoute(queryText: _searchController.text.trim()));
    }
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const MenuButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        onTap: onTap as void Function()?,
        child: Text(title,
      style:      TextStyle(
    color: const Color(0xff1a3922),
  fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.bold,
  fontSize: Dimensions.fontSizeDefault,
)
                ),
      );
    });
  }
}
class MenuButtons extends StatelessWidget {
  final String title;
  
  const MenuButtons({Key? key, required this.title, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return Text(title,
          style: robotoRegular.copyWith(
              color: hovered ? Colors.white :
                                Colors.white));
    });
  }
}

class MenuIconButton extends StatelessWidget {
  final IconData icon;
  final bool isCart;
  final Function onTap;
  const MenuIconButton(
      {Key? key, required this.icon, this.isCart = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return IconButton(
        onPressed: onTap as void Function()?,
        icon: GetBuilder<CartController>(builder: (cartController) {
          return Stack(clipBehavior: Clip.none, children: [
            Icon(
              icon,
              color: hovered
                  ? const Color(0xffBCDEC2)
                  : const Color(0xffBCDEC2),
            ),
            (isCart && cartController.cartList.isNotEmpty)
                ? Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      height: 15,
                      width: 15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        cartController.cartList.length.toString(),
                        style: robotoRegular.copyWith(
                            fontSize: 12, color: Theme.of(context).cardColor),
                      ),
                    ),
                  )
                : const SizedBox()
          ]);
        }),
      );
    });
  }
}
