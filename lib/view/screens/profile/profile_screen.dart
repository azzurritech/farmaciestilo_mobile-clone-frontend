import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/controller/theme_controller.dart';
import 'package:farmacie_stilo/controller/user_controller.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/confirmation_dialog.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/web_menu_bar.dart';
import 'package:farmacie_stilo/view/screens/profile/all_booked_slots_view.dart';
import 'package:farmacie_stilo/view/screens/profile/allooking_slots.dart';
import 'package:farmacie_stilo/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:farmacie_stilo/view/screens/profile/widget/profile_button.dart';
import 'package:farmacie_stilo/view/screens/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();

    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  Future<void> initializeSharedPreferences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final dsa = shared.getInt("user_id");
    String? name = shared.getString("fname");
    String? email = shared.getString("email");
    print(dsa.toString());
    print(name.toString());
    print(email.toString());
  }

  @override
  Widget build(BuildContext context) {
    final bool showWalletCard =
        Get.find<SplashController>().configModel!.customerWalletStatus == 1 ||
            Get.find<SplashController>().configModel!.loyaltyPointStatus == 1;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? const Center(child: CircularProgressIndicator())
            : ProfileBgWidget(
                backButton: true,
                circularImage: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).cardColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: ClipOval(
                      child: CustomImage(
                    image:
                        '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}'
                        '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel!.image : ''}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
                ),
                mainWidget: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: FooterView(
                      minHeight: _isLoggedIn ? 0.6 : 0.35,
                      child: Center(
                          child: Container(
                        width: Dimensions.webMaxWidth,
                        height: context.height,
                        color: Theme.of(context).cardColor,
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Column(children: [
                          Text(
                            _isLoggedIn
                                ? '${userController.userInfoModel!.fName} ${userController.userInfoModel!.lName}'
                                : 'guest'.tr,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          const SizedBox(height: 30),
                          _isLoggedIn
                              ? Row(children: [
                                  ProfileCard(
                                      title: 'since_joining'.tr,
                                      data:
                                          '${userController.userInfoModel!.memberSinceDays} ${'days'.tr}'),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                  ProfileCard(
                                      title: 'total_order'.tr,
                                      data: userController
                                          .userInfoModel!.orderCount
                                          .toString()),
                                ])
                              : const SizedBox(),
                          SizedBox(
                              height: showWalletCard
                                  ? Dimensions.paddingSizeSmall
                                  : 0),
                          (showWalletCard && _isLoggedIn)
                              ? Row(children: [
                                  Get.find<SplashController>()
                                              .configModel!
                                              .customerWalletStatus ==
                                          1
                                      ? ProfileCard(
                                          title: 'wallet_amount'.tr,
                                          data: PriceConverter.convertPrice(
                                              userController.userInfoModel!
                                                  .walletBalance),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                      width: Get.find<SplashController>()
                                                      .configModel!
                                                      .customerWalletStatus ==
                                                  1 &&
                                              Get.find<SplashController>()
                                                      .configModel!
                                                      .loyaltyPointStatus ==
                                                  1
                                          ? Dimensions.paddingSizeSmall
                                          : 0.0),
                                  Get.find<SplashController>()
                                              .configModel!
                                              .loyaltyPointStatus ==
                                          1
                                      ? ProfileCard(
                                          title: 'loyalty_points'.tr,
                                          data: userController.userInfoModel!
                                                      .loyaltyPoint !=
                                                  null
                                              ? userController
                                                  .userInfoModel!.loyaltyPoint
                                                  .toString()
                                              : '0',
                                        )
                                      : const SizedBox.shrink(),
                                ])
                              : const SizedBox(),
                          SizedBox(height: _isLoggedIn ? 30 : 0),
                          ProfileButton(
                              icon: Icons.dark_mode,
                              title: 'dark_mode'.tr,
                              isButtonActive: Get.isDarkMode,
                              onTap: () {
                                Get.find<ThemeController>().toggleTheme();
                              }),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          _isLoggedIn
                              ? GetBuilder<AuthController>(
                                  builder: (authController) {
                                  return ProfileButton(
                                    icon: Icons.notifications,
                                    title: 'notification'.tr,
                                    isButtonActive: authController.notification,
                                    onTap: () {
                                      authController.setNotificationActive(
                                          !authController.notification);
                                    },
                                  );
                                })
                              : const SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? Dimensions.paddingSizeSmall
                                  : 0),
                          _isLoggedIn
                              ? userController.userInfoModel!.socialId == null
                                  ? ProfileButton(
                                      icon: Icons.lock,
                                      title: 'change_password'.tr,
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getResetPasswordRoute(
                                                '', '', 'password-change'));
                                      })
                                  : const SizedBox()
                              : const SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? userController.userInfoModel!.socialId ==
                                          null
                                      ? Dimensions.paddingSizeSmall
                                      : 0
                                  : 0),
                          ProfileButton(
                              icon: Icons.edit,
                              title: 'edit_profile'.tr,
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getUpdateProfileRoute());
                              }),
                                  SizedBox(
                              height: _isLoggedIn
                                  ? userController.userInfoModel!.socialId ==
                                          null
                                      ? Dimensions.paddingSizeSmall
                                      : 0
                                  : 0),
                        // ignore: unrelated_type_equality_checks
                        _isLoggedIn ?   ProfileButton(
                              icon: Icons.calendar_month,
                              title: 'see_video_call_booked_slots'.tr,
                              onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllBookedSlotsView(),));
                              }): SizedBox(),
                                // ignore: unrelated_type_equality_checks
                                _isLoggedIn ?       ProfileButton(
                              icon: Icons.calendar_month,
                              title: 'see_booked_slots'.tr,
                              onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllBookingSlots(),));
                              }):SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? Dimensions.paddingSizeSmall
                                  : Dimensions.paddingSizeLarge),
                          _isLoggedIn
                              ? ProfileButton(
                                  icon: Icons.delete,
                                  title: 'delete_account'.tr,
                                  onTap: () {
                                    Get.dialog(
                                        ConfirmationDialog(
                                          icon: Images.support,
                                          title:
                                              'are_you_sure_to_delete_account'
                                                  .tr,
                                          description:
                                              'it_will_remove_your_all_information'
                                                  .tr,
                                          isLogOut: true,
                                          onYesPressed: () =>
                                              userController.removeUser(),
                                        ),
                                        useSafeArea: false);
                                  },
                                )
                              : const SizedBox(),
                          SizedBox(
                              height: _isLoggedIn
                                  ? Dimensions.paddingSizeLarge
                                  : 0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${'version'.tr}:',
                                    style: robotoRegular.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraSmall)),
                                const SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall),
                                Text(AppConstants.appVersion.toString(),
                                    style: robotoMedium.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraSmall)),
                              ]),
                        ]),
                      )),
                    )),
              );
      }),
    );
  }
}
