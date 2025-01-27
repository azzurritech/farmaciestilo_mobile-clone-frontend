import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/controller/parcel_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/controller/user_controller.dart';
import 'package:farmacie_stilo/data/model/body/place_order_body.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/parcel_category_model.dart';
import 'package:farmacie_stilo/data/model/response/zone_response_model.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:farmacie_stilo/view/base/custom_button.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/not_logged_in_screen.dart';
import 'package:farmacie_stilo/view/screens/checkout/widget/condition_check_box.dart';
import 'package:farmacie_stilo/view/screens/checkout/widget/payment_button.dart';
import 'package:farmacie_stilo/view/screens/checkout/widget/tips_widget.dart';
import 'package:farmacie_stilo/view/screens/parcel/widget/card_widget.dart';
import 'package:farmacie_stilo/view/screens/parcel/widget/details_widget.dart';
import 'package:universal_html/html.dart' as html;

class ParcelRequestScreen extends StatefulWidget {
  final ParcelCategoryModel parcelCategory;
  final AddressModel pickedUpAddress;
  final AddressModel destinationAddress;
  const ParcelRequestScreen(
      {Key? key,
      required this.parcelCategory,
      required this.pickedUpAddress,
      required this.destinationAddress})
      : super(key: key);

  @override
  State<ParcelRequestScreen> createState() => _ParcelRequestScreenState();
}

class _ParcelRequestScreenState extends State<ParcelRequestScreen> {
  final TextEditingController _tipController = TextEditingController();
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  bool? _isCashOnDeliveryActive = false;
  bool? _isDigitalPaymentActive = false;

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn) {
      Get.find<ParcelController>()
          .getDistance(widget.pickedUpAddress, widget.destinationAddress);
      Get.find<ParcelController>().setPayerIndex(0, false);
      for (ZoneData zData
          in Get.find<LocationController>().getUserAddress()!.zoneData!) {
        if (zData.id ==
            Get.find<LocationController>().getUserAddress()!.zoneId) {
          _isCashOnDeliveryActive = zData.cashOnDelivery;
          _isDigitalPaymentActive = zData.digitalPayment;
          if (Get.find<ParcelController>().payerIndex == 0) {
            Get.find<ParcelController>().setPaymentIndex(
                _isCashOnDeliveryActive!
                    ? 0
                    : _isDigitalPaymentActive!
                        ? 1
                        : 2,
                false);
          } else {
            Get.find<ParcelController>().setPaymentIndex(0, false);
          }
        }
      }
      if (Get.find<UserController>().userInfoModel == null) {
        Get.find<UserController>().getUserInfo();
      }
      Get.find<OrderController>().updateTips(-1, notify: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'parcel_request'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<ParcelController>(builder: (parcelController) {
        double charge = -1;
        if (parcelController.distance != -1 && _isLoggedIn) {
          double parcelPerKmShippingCharge =
              widget.parcelCategory.parcelPerKmShippingCharge! > 0
                  ? widget.parcelCategory.parcelPerKmShippingCharge!
                  : Get.find<SplashController>()
                      .configModel!
                      .parcelPerKmShippingCharge!;
          double parcelMinimumShippingCharge =
              widget.parcelCategory.parcelMinimumShippingCharge! > 0
                  ? widget.parcelCategory.parcelMinimumShippingCharge!
                  : Get.find<SplashController>()
                      .configModel!
                      .parcelMinimumShippingCharge!;
          charge = parcelController.distance! * parcelPerKmShippingCharge;
          if (charge < parcelMinimumShippingCharge) {
            charge = parcelMinimumShippingCharge;
          }
        }

        return _isLoggedIn
            ? Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                  padding: ResponsiveHelper.isDesktop(context)
                      ? null
                      : const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: FooterView(
                      child: SizedBox(
                          width: Dimensions.webMaxWidth,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardWidget(
                                    child: Row(children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        shape: BoxShape.circle),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      child: CustomImage(
                                        image:
                                            '${Get.find<SplashController>().configModel!.baseUrls!.parcelCategoryImageUrl}'
                                            '/${widget.parcelCategory.image}',
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(widget.parcelCategory.name!,
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        Text(
                                          widget.parcelCategory.description!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                      ])),
                                ])),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                CardWidget(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                      DetailsWidget(
                                          title: 'sender_details'.tr,
                                          address: widget.pickedUpAddress),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeLarge),
                                      DetailsWidget(
                                          title: 'receiver_details'.tr,
                                          address: widget.destinationAddress),
                                    ])),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                CardWidget(
                                    child: Row(children: [
                                  Expanded(
                                      child: Row(children: [
                                    Image.asset(Images.distance,
                                        height: 30, width: 30),
                                    const SizedBox(
                                        width: Dimensions.paddingSizeSmall),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('distance'.tr,
                                              style: robotoRegular),
                                          Text(
                                            parcelController.distance == -1
                                                ? 'calculating'.tr
                                                : '${parcelController.distance!.toStringAsFixed(2)} ${'km'.tr}',
                                            style: robotoBold.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                  ])),
                                  Expanded(
                                      child: Row(children: [
                                    Image.asset(Images.delivery,
                                        height: 30, width: 30),
                                    const SizedBox(
                                        width: Dimensions.paddingSizeSmall),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('delivery_fee'.tr,
                                              style: robotoRegular),
                                          Text(
                                            parcelController.distance == -1
                                                ? 'calculating'.tr
                                                : PriceConverter.convertPrice(
                                                    charge),
                                            style: robotoBold.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ]),
                                  ]))
                                ])),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                (Get.find<SplashController>()
                                            .configModel!
                                            .dmTipsStatus ==
                                        1)
                                    ? GetBuilder<OrderController>(
                                        builder: (orderController) {
                                        return Container(
                                          color: Theme.of(context).cardColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeLarge,
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('delivery_man_tips'.tr,
                                                    style: robotoMedium),
                                                const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeSmall),
                                                Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radiusSmall),
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  child: TextField(
                                                    controller: _tipController,
                                                    onChanged: (String value) {
                                                      if (value.isNotEmpty) {
                                                        orderController.addTips(
                                                            double.parse(
                                                                value));
                                                      } else {
                                                        orderController
                                                            .addTips(0.0);
                                                      }
                                                    },
                                                    maxLength: 10,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'[0-9.]'))
                                                    ],
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'enter_amount'.tr,
                                                      counterText: '',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusSmall),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeDefault),
                                                SizedBox(
                                                  height: 55,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: AppConstants
                                                        .tips.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return TipsWidget(
                                                        title: AppConstants
                                                            .tips[index]
                                                            .toString(),
                                                        isSelected: orderController
                                                                .selectedTips ==
                                                            index,
                                                        onTap: () {
                                                          orderController
                                                              .updateTips(
                                                                  index);
                                                          orderController.addTips(
                                                              AppConstants
                                                                  .tips[index]
                                                                  .toDouble());
                                                          _tipController.text =
                                                              orderController
                                                                  .tips
                                                                  .toString();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ]),
                                        );
                                      })
                                    : const SizedBox.shrink(),
                                SizedBox(
                                    height: (Get.find<SplashController>()
                                                .configModel!
                                                .dmTipsStatus ==
                                            1)
                                        ? Dimensions.paddingSizeExtraSmall
                                        : 0),
                                Text('charge_pay_by'.tr, style: robotoMedium),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                Row(children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () =>
                                        parcelController.setPayerIndex(0, true),
                                    child: Row(children: [
                                      Radio<String>(
                                        value: parcelController.payerTypes[0],
                                        groupValue: parcelController.payerTypes[
                                            parcelController.payerIndex],
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        onChanged: (String? payerType) =>
                                            parcelController.setPayerIndex(
                                                0, true),
                                      ),
                                      Text(parcelController.payerTypes[0].tr,
                                          style: robotoRegular),
                                    ]),
                                  )),
                                  _isCashOnDeliveryActive!
                                      ? Expanded(
                                          child: InkWell(
                                          onTap: () => parcelController
                                              .setPayerIndex(1, true),
                                          child: Row(children: [
                                            Radio<String>(
                                              value: parcelController
                                                  .payerTypes[1],
                                              groupValue: parcelController
                                                      .payerTypes[
                                                  parcelController.payerIndex],
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              onChanged: (String? payerType) =>
                                                  parcelController
                                                      .setPayerIndex(1, true),
                                            ),
                                            Text(
                                                parcelController
                                                    .payerTypes[1].tr,
                                                style: robotoRegular),
                                          ]),
                                        ))
                                      : const SizedBox(),
                                ]),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                _isCashOnDeliveryActive!
                                    ? PaymentButton(
                                        icon: Images.cashOnDelivery,
                                        title: 'cash_on_delivery'.tr,
                                        subtitle:
                                            'pay_your_payment_after_getting_item'
                                                .tr,
                                        isSelected:
                                            parcelController.paymentIndex == 0,
                                        onTap: () => parcelController
                                            .setPaymentIndex(0, true),
                                      )
                                    : const SizedBox(),
                                (_isDigitalPaymentActive! &&
                                        parcelController.payerIndex == 0)
                                    ? PaymentButton(
                                        icon: Images.digitalPayment,
                                        title: 'digital_payment'.tr,
                                        subtitle: 'faster_and_safe_way'.tr,
                                        isSelected:
                                            parcelController.paymentIndex == 1,
                                        onTap: () => parcelController
                                            .setPaymentIndex(1, true),
                                      )
                                    : const SizedBox(),
                                (Get.find<SplashController>()
                                                .configModel!
                                                .customerWalletStatus ==
                                            1 &&
                                        parcelController.payerIndex == 0)
                                    ? PaymentButton(
                                        icon: Images.wallet,
                                        title: 'wallet_payment'.tr,
                                        subtitle:
                                            'pay_from_your_existing_balance'.tr,
                                        isSelected:
                                            parcelController.paymentIndex == 2,
                                        onTap: () => parcelController
                                            .setPaymentIndex(2, true),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                CheckoutCondition(
                                    orderController:
                                        Get.find<OrderController>(),
                                    parcelController: parcelController,
                                    isParcel: true),
                                SizedBox(
                                    height: ResponsiveHelper.isDesktop(context)
                                        ? Dimensions.paddingSizeLarge
                                        : 0),
                                ResponsiveHelper.isDesktop(context)
                                    ? _bottomButton(parcelController, charge)
                                    : const SizedBox(),
                              ]))),
                )),
                ResponsiveHelper.isDesktop(context)
                    ? const SizedBox()
                    : _bottomButton(parcelController, charge),
              ])
            : const NotLoggedInScreen();
      }),
    );
  }

  void orderCallback(bool isSuccess, String? message, String orderID,
      int? zoneID, double orderAmount, double? maxCodAmount) {
    Get.find<ParcelController>().startLoader(false);
    if (isSuccess) {
      if (Get.find<ParcelController>().paymentIndex == 1) {
        if (GetPlatform.isWeb) {
          Get.back();
          String? hostname = html.window.location.hostname;
          String protocol = html.window.location.protocol;
          String selectedUrl =
              '${AppConstants.baseUrl}/payment-mobile?order_id=$orderID&&customer_id=${Get.find<UserController>().userInfoModel!.id}&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&status=';
          html.window.open(selectedUrl, "_self");
        } else {
          Get.offNamed(RouteHelper.getPaymentRoute(
              orderID,
              Get.find<UserController>().userInfoModel!.id,
              'parcel',
              orderAmount,
              _isCashOnDeliveryActive));
        }
      } else {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));
      }
      Get.find<OrderController>().updateTips(-1, notify: false);
    } else {
      showCustomSnackBar(message);
    }
  }

  Widget _bottomButton(ParcelController parcelController, double charge) {
    return !parcelController.isLoading
        ? CustomButton(
            buttonText: 'confirm_parcel_request'.tr,
            margin: ResponsiveHelper.isDesktop(context)
                ? null
                : const EdgeInsets.all(Dimensions.paddingSizeSmall),
            onPressed: parcelController.acceptTerms
                ? () {
                    if (parcelController.distance == -1) {
                      showCustomSnackBar('delivery_fee_not_set_yet'.tr);
                    } else {
                      Get.find<ParcelController>().startLoader(true);
                      Get.find<OrderController>().placeOrder(
                          PlaceOrderBody(
                            code: '',
                            cart: [],
                            couponDiscountAmount: null,
                            distance: parcelController.distance,
                            scheduleAt: null,
                            orderAmount: charge,
                            orderNote: '',
                            orderType: 'parcel',
                            receiverDetails: widget.destinationAddress,
                            paymentMethod: parcelController.paymentIndex == 0
                                ? 'cash_on_delivery'
                                : parcelController.paymentIndex == 1
                                    ? 'digital_payment'
                                    : 'wallet',
                            couponCode: null,
                            storeId: null,
                            address: widget.pickedUpAddress.address,
                            latitude: widget.pickedUpAddress.latitude,
                            longitude: widget.pickedUpAddress.longitude,
                            addressType: widget.pickedUpAddress.addressType,
                            contactPersonName:
                                widget.pickedUpAddress.contactPersonName ?? '',
                            contactPersonNumber:
                                widget.pickedUpAddress.contactPersonNumber ??
                                    '',
                            streetNumber:
                                widget.pickedUpAddress.streetNumber ?? '',
                            house: widget.pickedUpAddress.house ?? '',
                            floor: widget.pickedUpAddress.floor ?? '',
                            discountAmount: 0,
                            taxAmount: 0,
                            parcelCategoryId:
                                widget.parcelCategory.id.toString(),
                            chargePayer: parcelController
                                .payerTypes[parcelController.payerIndex],
                            dmTips: _tipController.text.trim(),
                          ),
                          widget.pickedUpAddress.zoneId,
                          orderCallback,
                          0,
                          0);
                    }
                  }
                : null,
          )
        : const Center(child: CircularProgressIndicator());
  }
}
