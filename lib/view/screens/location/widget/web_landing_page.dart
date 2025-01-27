import 'dart:async';

import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/config_model.dart';
import 'package:farmacie_stilo/data/model/response/zone_response_model.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/custom_loader.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/screens/location/widget/landing_card.dart';
import 'package:farmacie_stilo/view/screens/location/widget/registration_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher_string.dart';

class WebLandingPage extends StatefulWidget {
  final bool fromSignUp;
  final bool fromHome;
  final String? route;
  const WebLandingPage(
      {Key? key,
      required this.fromSignUp,
      required this.fromHome,
      required this.route})
      : super(key: key);

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  final TextEditingController _controller = TextEditingController();
  final PageController _pageController = PageController();
  AddressModel? _address;
  final ConfigModel? _config = Get.find<SplashController>().configModel;
  Timer? _timer;
  bool? _isRtl;
  int currentinde=0;
List items=[Images.lanbanner1, Images.lanbanner2, Images.lanbanner3];
  @override
  void initState() {
    super.initState();

    // if(Get.find<SplashController>().moduleList == null) {
    //   Get.find<SplashController>().getModules();
    // }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isRtl = intl.Bidi.isRtlLanguage(Get.locale!.languageCode);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FooterView(
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: SizedBox(
              
                child: Column(children: [
                        Container(
                          
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(  '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.topContentImage : ''}',
                      //        )),
                        image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Get.find<LocalizationController>().locale?.languageCode=="en" ?AssetImage(  Images.landingen    ) : AssetImage(Images.landingit)),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      // color: Colors.red,
                    ),
                    child: Row(children: [
                      const SizedBox(width: 40),
                   
                      // Expanded(
                      //     child: ClipPath(
                      //         clipper: CustomPath(isRtl: _isRtl),
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.horizontal(
                      //             right: _isRtl!
                      //                 ? const Radius.circular(0)
                      //                 : const Radius.circular(
                      //                     Dimensions.radiusDefault),
                      //             left: _isRtl!
                      //                 ? const Radius.circular(
                      //                     Dimensions.radiusDefault)
                      //                 : const Radius.circular(0),
                      //           ),
                      //           child: CustomImage(
                      //             image:
                      //                 '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.topContentImage : ''}',
                      //             height: 270,
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ))),
                    ]),
                  ),

// Container(
//   height: 400,
//        width: MediaQuery.of(context).size.width,
//   child: CarouselSlider.builder(itemCount: items.length, options: CarouselOptions(
  
//    autoPlay: true,
//                                   enlargeCenterPage: true,
//                                   onPageChanged: ((index, reason) {
//                                    setState(() {
//                                      currentinde=index;
//                                    });
//                                   }),
//                                   disableCenter: true,
//                                   viewportFraction: 1,
//                                   autoPlayInterval: const Duration(seconds: 3),
  
//   ), itemBuilder: (context, index, _)  { 
//   return    Container(
                      
//                     width: MediaQuery.of(context).size.width,
//                       height: 320,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(image: AssetImage(  items[currentinde],
                        
                               
                               
//                                ), fit: BoxFit.contain
//                                ),
//                         borderRadius:
//                             BorderRadius.circular(Dimensions.radiusDefault),
//                             // color: Colors.red
//                          color: Theme.of(context).primaryColor.withOpacity(0.05),
//                       ),
//                       Row(children: [
//                         const SizedBox(width: 40),
//                         // Expanded(
                       
//                         //     child: Column(
//                         //         crossAxisAlignment: CrossAxisAlignment.start,
//                         //         mainAxisAlignment: MainAxisAlignment.center,
//                         //         children: [
//                         //       Text(AppConstants.appName,
//                         //           style: robotoBold.copyWith(fontSize: 35)),
//                         //       const SizedBox(height: Dimensions.paddingSizeLarge),
//                         //       Text(
//                         //         'more_than_just_a_reliable_ecommerce_platform'.tr,
//                         //         style: robotoMedium.copyWith(
//                         //             fontSize: Dimensions.fontSizeDefault,
//                         //           color: const Color(0xff1c592d)),
//                         //       ),
//                         //     ])),
//                       ])
                        // Expanded(
                        //   flex: 0,
                        //     child: ClipPath(
                        //         clipper: CustomPath(isRtl: _isRtl),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.horizontal(
                        //             right: _isRtl!
                        //                 ? const Radius.circular(0)
                        //                 : const Radius.circular(
                        //                     Dimensions.radiusDefault),
                        //             left: _isRtl!
                        //                 ? const Radius.circular(
                        //                     Dimensions.radiusDefault)
                        //                 : const Radius.circular(0),
                        //           ),
                        //           child:
                                  
                        //            CustomImage(
                        //             image:
                        //                 '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.topContentImage : ''}',
                        //             height: 270,
                        //             fit: BoxFit.cover,
                        //           ),
                        //        ))),
//                       // ]
//                       // ),
//                     );
//    },),
// ),







                  
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  // Container(
                    
                  //   // width: MediaQuery.of(context).size.w,
                  //   height: 320,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(image: NetworkImage(  '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.topContentImage : ''}',
                      
                             
                             
                  //            ), fit: BoxFit.cover
                  //            ),
                  //     borderRadius:
                  //         BorderRadius.circular(Dimensions.radiusDefault),
                  //         // color: Colors.red
                  //      color: Theme.of(context).primaryColor.withOpacity(0.05),
                  //   ),
                  //   child: Row(children: [
                  //     const SizedBox(width: 40),
                  //     // Expanded(
                     
                  //     //     child: Column(
                  //     //         crossAxisAlignment: CrossAxisAlignment.start,
                  //     //         mainAxisAlignment: MainAxisAlignment.center,
                  //     //         children: [
                  //     //       Text(AppConstants.appName,
                  //     //           style: robotoBold.copyWith(fontSize: 35)),
                  //     //       const SizedBox(height: Dimensions.paddingSizeLarge),
                  //     //       Text(
                  //     //         'more_than_just_a_reliable_ecommerce_platform'.tr,
                  //     //         style: robotoMedium.copyWith(
                  //     //             fontSize: Dimensions.fontSizeDefault,
                  //     //           color: const Color(0xff1c592d)),
                  //     //       ),
                  //     //     ])),
                  //   ])
                  //   //   Expanded(
                  //   //     flex: 0,
                  //   //       child: ClipPath(
                  //   //           clipper: CustomPath(isRtl: _isRtl),
                  //   //           child: ClipRRect(
                  //   //             borderRadius: BorderRadius.horizontal(
                  //   //               right: _isRtl!
                  //   //                   ? const Radius.circular(0)
                  //   //                   : const Radius.circular(
                  //   //                       Dimensions.radiusDefault),
                  //   //               left: _isRtl!
                  //   //                   ? const Radius.circular(
                  //   //                       Dimensions.radiusDefault)
                  //   //                   : const Radius.circular(0),
                  //   //             ),
                  //   //             child:
                                
                  //   //              CustomImage(
                  //   //               image:
                  //   //                   '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.topContentImage : ''}',
                  //   //               height: 270,
                  //   //               fit: BoxFit.cover,
                  //   //             ),
                  //   //           ))),
                  //   // ]
                  //   // ),
                  // ),
                  const SizedBox(height: 20),
                  Stack(children: [
                    // ClipRRect(
                      
                    //   borderRadius:
                    //       BorderRadius.circular(Dimensions.radiusDefault),
                    //   child: Opacity(
                    //       opacity: 0.05,
                    //       child: Image.asset(Images.landingBg,
                    //           height: 130,
                    //           width: context.width,
                    //           fit: BoxFit.fill)),
                    // ),
            Get.find<LocalizationController>().locale?.languageCode=="it" ?        InkWell(
                      onTap: ()async{
   Get.dialog(const CustomLoader(),
                                              barrierDismissible: false);
                                          _address =
                                              await Get.find<LocationController>()
                                                  .getCurrentLocation(true);
                                          _controller.text = _address!.address!;
                                    if (_address != null &&
                                        _controller.text.trim().isNotEmpty) {
                                      Get.dialog(const CustomLoader(),
                                          barrierDismissible: false);
                                      ZoneResponseModel response =
                                          await Get.find<LocationController>()
                                              .getZone(
                                       '45.46532432494875',
                                       '9.167883803503045',
                                        false,
                                      );
                                      if (response.isSuccess) {
                                        Get.find<LocationController>()
                                            .saveAddressAndNavigate(
                                          _address,
                                          widget.fromSignUp,
                                          widget.route,
                                          widget.route != null,
                                          ResponsiveHelper.isDesktop(Get.context),
                                        );
                                      } else {
                                        Get.back();
                                        showCustomSnackBar(
                                            'service_not_available_in_current_location'
                                                .tr);
                                      }
                                    } else {
                                      showCustomSnackBar('pick_an_address'.tr);
                                    }
                      },
                      child: Container(
                        height: 290,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                       image: DecorationImage(image: AssetImage(Images.banneritalian), fit: BoxFit.cover)
                        ),
                        child: Row(children: [
                          // Expanded(
                          //     flex: 3,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(
                          //           Dimensions.paddingSizeSmall),
                          //       child: Column(children: [
                          //         Image.asset(Images.landingChooseLocation,
                          //             height: 70, width: 70),
                          //         const SizedBox(
                          //             height: Dimensions.paddingSizeExtraSmall),
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: Dimensions.paddingSizeLarge),
                          //           child: Text(
                          //             'choose your product'.tr,
                          //             textAlign: TextAlign.center,
                          //             style: robotoMedium.copyWith(
                          //                 fontSize: Dimensions.fontSizeSmall),
                          //           ),
                          //         ),
                                  
                          //       ]),
                          //     )),
                              
                          // Expanded(
                          //     flex: 7,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(
                          //           Dimensions.paddingSizeLarge),
                          //       child: Row(children: [
                          //         Expanded(
                          //           child: TypeAheadField(
                          //           textFieldConfiguration: TextFieldConfiguration(
                          //             controller: _controller,
                          //             textInputAction: TextInputAction.search,
                          //             textCapitalization: TextCapitalization.words,
                          //             keyboardType: TextInputType.streetAddress,
                          //             decoration: InputDecoration(
                          //               hintText: 'search_location'.tr,
                          //               border: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide: BorderSide(
                          //                     color: Theme.of(context)
                          //                         .primaryColor
                          //                         .withOpacity(0.3),
                          //                     width: 1),
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide: BorderSide(
                          //                     color: Theme.of(context)
                          //                         .primaryColor
                          //                         .withOpacity(0.3),
                          //                     width: 1),
                          //               ),
                          //               hintStyle: Theme.of(context)
                          //                   .textTheme
                          //                   .displayMedium!
                          //                   .copyWith(
                          //                     fontSize: Dimensions.fontSizeDefault,
                          //                     color:
                          //                         Theme.of(context).disabledColor,
                          //                   ),
                          //               filled: true,
                          //               fillColor: Theme.of(context).cardColor,
                          //               suffixIcon: IconButton(
                          //                 onPressed: () async {
                          //                   Get.dialog(const CustomLoader(),
                          //                       barrierDismissible: false);
                          //                   _address =
                          //                       await Get.find<LocationController>()
                          //                           .getCurrentLocation(true);
                          //                   _controller.text = _address!.address!;
                          //                   Get.back();
                          //                 },
                          //                 icon: Icon(Icons.my_location,
                          //                     color:
                          //                         Theme.of(context).primaryColor),
                          //               ),
                          //             ),
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .displayMedium!
                          //                 .copyWith(
                          //                   color: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyLarge!
                          //                       .color,
                          //                   fontSize: Dimensions.fontSizeLarge,
                          //                 ),
                          //           ),
                          //           suggestionsCallback: (pattern) async {
                          //             return await Get.find<LocationController>()
                          //                 .searchLocation(context, pattern);
                          //           },
                          //           itemBuilder:
                          //               (context, PredictionModel suggestion) {
                          //             return Padding(
                          //               padding: const EdgeInsets.all(
                          //                   Dimensions.paddingSizeSmall),
                          //               child: Row(children: [
                          //                 const Icon(Icons.location_on),
                          //                 Expanded(
                          //                     child: Text(
                          //                   suggestion.description!,
                          //                   maxLines: 1,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .displayMedium!
                          //                       .copyWith(
                          //                         color: Theme.of(context)
                          //                             .textTheme
                          //                             .bodyLarge!
                          //                             .color,
                          //                         fontSize:
                          //                             Dimensions.fontSizeLarge,
                          //                       ),
                          //                 )),
                          //               ]),
                          //             );
                          //           },
                          //           onSuggestionSelected:
                          //               (PredictionModel suggestion) async {
                          //             _controller.text = suggestion.description!;
                          //             _address =
                          //                 await Get.find<LocationController>()
                          //                     .setLocation(suggestion.placeId,
                          //                         suggestion.description, null);
                          //           },
                          //         )),
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeSmall),
                               
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeSmall),
                          //         CustomButton(
                          //           width: 160,
                          //           height: 60,
                          //           fontSize: Dimensions.fontSizeDefault,
                          //           buttonText: 'pick_from_map'.tr,
                          //           onPressed: () =>
                          //               Get.toNamed(RouteHelper.getPickMapRoute(
                          //             widget.route ??
                          //                 (widget.fromSignUp
                          //                     ? RouteHelper.signUp
                          //                     : RouteHelper.accessLocation),
                          //             widget.route != null,
                          //           )),
                          //         ),
                          //       ]),
                          //     )),
                        ]),
                      ),
                    ):   InkWell(
                      onTap: ()async{
   Get.dialog(const CustomLoader(),
                                              barrierDismissible: false);
                                          _address =
                                              await Get.find<LocationController>()
                                                  .getCurrentLocation(true);
                                          _controller.text = _address!.address!;
                                    if (_address != null &&
                                        _controller.text.trim().isNotEmpty) {
                                      Get.dialog(const CustomLoader(),
                                          barrierDismissible: false);
                                      ZoneResponseModel response =
                                          await Get.find<LocationController>()
                                              .getZone(
                                       '45.46532432494875',
                                       '9.167883803503045',
                                        false,
                                      );
                                      if (response.isSuccess) {
                                        Get.find<LocationController>()
                                            .saveAddressAndNavigate(
                                          _address,
                                          widget.fromSignUp,
                                          widget.route,
                                          widget.route != null,
                                          ResponsiveHelper.isDesktop(Get.context),
                                        );
                                      } else {
                                        Get.back();
                                        showCustomSnackBar(
                                            'service_not_available_in_current_location'
                                                .tr);
                                      }
                                    } else {
                                      showCustomSnackBar('pick_an_address'.tr);
                                    }
                      },
                      child: Container(
                        height: 290,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                       image: DecorationImage(image: AssetImage(Images.bannerenglish), fit: BoxFit.cover)
                        ),
                        child: Row(children: [
                          // Expanded(
                          //     flex: 3,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(
                          //           Dimensions.paddingSizeSmall),
                          //       child: Column(children: [
                          //         Image.asset(Images.landingChooseLocation,
                          //             height: 70, width: 70),
                          //         const SizedBox(
                          //             height: Dimensions.paddingSizeExtraSmall),
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: Dimensions.paddingSizeLarge),
                          //           child: Text(
                          //             'choose your product'.tr,
                          //             textAlign: TextAlign.center,
                          //             style: robotoMedium.copyWith(
                          //                 fontSize: Dimensions.fontSizeSmall),
                          //           ),
                          //         ),
                                  
                          //       ]),
                          //     )),
                              
                          // Expanded(
                          //     flex: 7,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(
                          //           Dimensions.paddingSizeLarge),
                          //       child: Row(children: [
                          //         Expanded(
                          //           child: TypeAheadField(
                          //           textFieldConfiguration: TextFieldConfiguration(
                          //             controller: _controller,
                          //             textInputAction: TextInputAction.search,
                          //             textCapitalization: TextCapitalization.words,
                          //             keyboardType: TextInputType.streetAddress,
                          //             decoration: InputDecoration(
                          //               hintText: 'search_location'.tr,
                          //               border: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide: BorderSide(
                          //                     color: Theme.of(context)
                          //                         .primaryColor
                          //                         .withOpacity(0.3),
                          //                     width: 1),
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //                 borderSide: BorderSide(
                          //                     color: Theme.of(context)
                          //                         .primaryColor
                          //                         .withOpacity(0.3),
                          //                     width: 1),
                          //               ),
                          //               hintStyle: Theme.of(context)
                          //                   .textTheme
                          //                   .displayMedium!
                          //                   .copyWith(
                          //                     fontSize: Dimensions.fontSizeDefault,
                          //                     color:
                          //                         Theme.of(context).disabledColor,
                          //                   ),
                          //               filled: true,
                          //               fillColor: Theme.of(context).cardColor,
                          //               suffixIcon: IconButton(
                          //                 onPressed: () async {
                          //                   Get.dialog(const CustomLoader(),
                          //                       barrierDismissible: false);
                          //                   _address =
                          //                       await Get.find<LocationController>()
                          //                           .getCurrentLocation(true);
                          //                   _controller.text = _address!.address!;
                          //                   Get.back();
                          //                 },
                          //                 icon: Icon(Icons.my_location,
                          //                     color:
                          //                         Theme.of(context).primaryColor),
                          //               ),
                          //             ),
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .displayMedium!
                          //                 .copyWith(
                          //                   color: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyLarge!
                          //                       .color,
                          //                   fontSize: Dimensions.fontSizeLarge,
                          //                 ),
                          //           ),
                          //           suggestionsCallback: (pattern) async {
                          //             return await Get.find<LocationController>()
                          //                 .searchLocation(context, pattern);
                          //           },
                          //           itemBuilder:
                          //               (context, PredictionModel suggestion) {
                          //             return Padding(
                          //               padding: const EdgeInsets.all(
                          //                   Dimensions.paddingSizeSmall),
                          //               child: Row(children: [
                          //                 const Icon(Icons.location_on),
                          //                 Expanded(
                          //                     child: Text(
                          //                   suggestion.description!,
                          //                   maxLines: 1,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .displayMedium!
                          //                       .copyWith(
                          //                         color: Theme.of(context)
                          //                             .textTheme
                          //                             .bodyLarge!
                          //                             .color,
                          //                         fontSize:
                          //                             Dimensions.fontSizeLarge,
                          //                       ),
                          //                 )),
                          //               ]),
                          //             );
                          //           },
                          //           onSuggestionSelected:
                          //               (PredictionModel suggestion) async {
                          //             _controller.text = suggestion.description!;
                          //             _address =
                          //                 await Get.find<LocationController>()
                          //                     .setLocation(suggestion.placeId,
                          //                         suggestion.description, null);
                          //           },
                          //         )),
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeSmall),
                               
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeSmall),
                          //         CustomButton(
                          //           width: 160,
                          //           height: 60,
                          //           fontSize: Dimensions.fontSizeDefault,
                          //           buttonText: 'pick_from_map'.tr,
                          //           onPressed: () =>
                          //               Get.toNamed(RouteHelper.getPickMapRoute(
                          //             widget.route ??
                          //                 (widget.fromSignUp
                          //                     ? RouteHelper.signUp
                          //                     : RouteHelper.accessLocation),
                          //             widget.route != null,
                          //           )),
                          //         ),
                          //       ]),
                          //     )),
                        ]),
                      ),
                    ),
                  ]),
                  // const SizedBox(height: 40),
                  // Text(
                  //   'your_ecommerce_venture_starts_here'.tr,
                  //   style: robotoBold.copyWith(
                  //       fontSize: Dimensions.fontSizeLarge,
                  //        color: const Color(0xff1c592d)),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'enjoy_all_services_in_one_platform'.tr,
                  //       style: robotoRegular.copyWith(
                  //           fontSize: Dimensions.fontSizeDefault,
                  //           color: Theme.of(context).disabledColor),
                  //     ),
                    

                  //     IconButton(onPressed: ()async{
       
                                    
                                  
                                
                  //     }, icon: const Icon(Icons.forward_sharp, size: 50, color: Color(0xff093b06),))
                  //   ],
                  // ),
                  // const SizedBox(height: 40),

                  // GetBuilder<SplashController>(builder: (splashController) {
                  //   if (splashController.moduleList != null && _timer == null) {
                  //     _timer =
                  //         Timer.periodic(const Duration(seconds: 5), (timer) {
                  //       int index = splashController.moduleIndex >=
                  //               splashController.moduleList!.length - 1
                  //           ? 0
                  //           : splashController.moduleIndex + 1;
                  //       splashController.setModuleIndex(index);
                  //       _pageController.animateToPage(index,
                  //           duration: const Duration(seconds: 2),
                  //           curve: Curves.easeInOut);
                  //     });
                  //   }
                  //   return splashController.moduleList != null
                  //       ? SizedBox(
                  //           height: 450,
                  //           child: Stack(children: [
                  //             // PageView.builder(
                  //             //   controller: _pageController,
                  //             //   itemCount: splashController.moduleList!.length,
                  //             //   onPageChanged: (int index) =>
                  //             //       splashController.setModuleIndex(index >=
                  //             //               splashController.moduleList!.length
                  //             //           ? 0
                  //             //           : index),
                  //             //   itemBuilder: (context, index) {
                  //             //     index = splashController.moduleIndex >=
                  //             //             splashController.moduleList!.length
                  //             //         ? 0
                  //             //         : splashController.moduleIndex;
                  //             //     return Padding(
                  //             //       padding: const EdgeInsets.symmetric(
                  //             //           horizontal: Dimensions.paddingSizeLarge),
                  //             //       child: Row(children: [
                  //             //         Expanded(
                  //             //             child: Column(
                  //             //                 crossAxisAlignment:
                  //             //                     CrossAxisAlignment.start,
                  //             //                 children: [
                  //             //               const SizedBox(height: 80),
                  //             //               Text(
                  //             //                 splashController
                  //             //                     .moduleList![index].moduleName!,
                  //             //                 style: robotoBold.copyWith(
                  //             //                     fontSize:
                  //             //                         Dimensions.fontSizeDefault),
                  //             //                 textAlign: TextAlign.center,
                  //             //               ),
                  //             //               const SizedBox(
                  //             //                   height:
                  //             //                       Dimensions.paddingSizeSmall),
                  //             //               Expanded(
                  //             //                   child: SingleChildScrollView(
                  //             //                 physics:
                  //             //                     const BouncingScrollPhysics(),
                  //             //                 padding: EdgeInsets.zero,
                  //             //                 child: Html(
                  //             //                   data: splashController
                  //             //                           .moduleList![index]
                  //             //                           .description ??
                  //             //                       '',
                  //             //                   shrinkWrap: true,
                  //             //                   onLinkTap: (String? url,
                                                  
                  //             //                       Map<String, String>
                  //             //                           attributes,
                  //             //                       element) {
                  //             //                     if (url!.startsWith('www.')) {
                  //             //                       url = 'https://$url';
                  //             //                     }
                  //             //                     if (kDebugMode) {
                  //             //                       print(
                  //             //                           'Redirect to url: $url');
                  //             //                     }
                  //             //                     html.window.open(url, "_blank");
                  //             //                   },
                  //             //                 ),
                  //             //               )),
                  //             //             ])),
                  //             //         CustomImage(
                  //             //           image:
                  //             //               '${_config!.baseUrls!.moduleImageUrl}/${splashController.moduleList![index].thumbnail}',
                  //             //           height: 450,
                  //             //           width: 450,
                  //             //         ),
                  //             //       ]),
                  //             //     );
                  //             //   },
                  //             // ),
                  //             Positioned(
                  //                 top: 0,
                  //                 left: 0,
                  //                 child: SizedBox(
                  //                     height: 75,
                  //                     child: Container(
                  //                       padding: const EdgeInsets.only(
                  //                           top: Dimensions.paddingSizeSmall,
                  //                           left: Dimensions.paddingSizeSmall),
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(
                  //                             Dimensions.radiusSmall),
                  //                         color: Theme.of(context)
                  //                             .scaffoldBackgroundColor,
                  //                       ),
                  //                       child: ListView.builder(
                  //                         shrinkWrap: true,
                  //                         scrollDirection: Axis.horizontal,
                  //                         itemCount:
                  //                             splashController.moduleList!.length,
                  //                         itemBuilder: (context, index) {
                  //                           return Padding(
                  //                             padding: const EdgeInsets.only(
                  //                                 right: Dimensions
                  //                                     .paddingSizeLarge),
                  //                             child: Column(children: [
                  //                               InkWell(
                  //                                 onTap: () {
                  //                                   splashController
                  //                                       .setModuleIndex(index);
                  //                                   _pageController.animateToPage(
                  //                                       index,
                  //                                       duration: const Duration(
                  //                                           seconds: 2),
                  //                                       curve: Curves.easeInOut);
                  //                                 },
                  //                                 child: CustomImage(
                  //                                   image:
                  //                                       '${_config!.baseUrls!.moduleImageUrl}/${splashController.moduleList![index].icon}',
                  //                                   height: 45,
                  //                                   width: 45,
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                   width: 45,
                  //                                   child: Divider(
                  //                                     color: splashController
                  //                                                 .moduleIndex ==
                  //                                             index
                  //                                         ? Theme.of(context)
                  //                                             .primaryColor
                  //                                         : Colors.transparent,
                  //                                     thickness: 2,
                  //                                   )),
                  //                             ]),
                  //                           );
                  //                         },
                  //                       ),
                  //                     ))),
                  //           ]))
                  //       : const SizedBox();
                  // }),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:19.0),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffD5EBC8),width:1.4 ),
                        borderRadius: BorderRadius.circular(62) ,   color: Color(0xffE8E7E5),),
                                     
                      child: Row(children: _generateChooseUsList())),
                  ),
                  SizedBox(
                      height: AppConstants.whyChooseUsList.isNotEmpty ? 40 : 0),
                  _config!.toggleStoreRegistration!
                      ? const RegistrationCard(isStore: true)
                      : const SizedBox(),
                  SizedBox(height: _config!.toggleStoreRegistration! ? 40 : 0),
                  (_config!.landingPageLinks!.appUrlAndroidStatus == '1' ||
                          _config!.landingPageLinks!.appUrlIosStatus == '1')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              CustomImage(
                                image:
                                    '${_config!.baseUrls!.landingPageImageUrl}/${_config!.landingPageSettings != null ? _config!.landingPageSettings!.mobileAppSectionImage : ''}',
                                width: 500,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                      color: Color(0xffFCDDD3),
                                  borderRadius: BorderRadius.circular(14)),
                                width: 350,
                                height: 400,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                 
                                  Text(
                                    'Download app \n to \n enjoy more!',
                                    textAlign: TextAlign.center,
                                    style:
 TextStyle(
   color:  Colors.white,
  fontFamily: 'FiraSans',
  fontWeight: FontWeight.w700,
  fontSize: 30.3,
)
                                  ),
                                  const SizedBox(
                                      height: 25),
                                  // Text(
                                  //   'download_our_app_from'.tr,
                                  //   textAlign: TextAlign.center,
                                  //   style: robotoRegular.copyWith(
                                  //       color: Theme.of(context).disabledColor,
                                  //       fontSize: Dimensions.fontSizeSmall),
                                  // ),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeLarge),
                                  _config!.landingPageLinks!
                                              .appUrlAndroidStatus ==
                                          '1'
                                      ? InkWell(
                                          onTap: () async {
                                            if (await canLaunchUrlString(_config!
                                                .landingPageLinks!
                                                .appUrlAndroid!)) {
                                              launchUrlString(_config!
                                                  .landingPageLinks!
                                                  .appUrlAndroid!);
                                            }
                                          },
                                          child: Image.asset(
                                              Images.landingGooglePlay,
                                              height: 105),
                                        )
                                      : const SizedBox(),
                                      SizedBox(height: 6,),
                                  SizedBox(
                                      width: (_config!.landingPageLinks!
                                                      .appUrlAndroidStatus ==
                                                  '1' &&
                                              _config!.landingPageLinks!
                                                      .appUrlIosStatus ==
                                                  '1')
                                          ? Dimensions.paddingSizeLarge
                                          : 0),
                                  _config!.landingPageLinks!.appUrlIosStatus ==
                                          '1'
                                      ? InkWell(
                                          onTap: () async {
                                            if (await canLaunchUrlString(_config!
                                                .landingPageLinks!.appUrlIos!)) {
                                              launchUrlString(_config!
                                                  .landingPageLinks!.appUrlIos!);
                                            }
                                          },
                                          child: Image.asset(
                                              Images.landingAppStore,
                                              height: 85, fit: BoxFit.fill,),
                                        )
                                      : const SizedBox(),
                                ]),
                              ),
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 40),
                  _config!.toggleDmRegistration!
                      ? const RegistrationCard(isStore: false)
                      : const SizedBox(),
                  SizedBox(height: _config!.toggleDmRegistration! ? 40 : 0),
                ])),
          )),
    );
  }

  List<Widget> _generateChooseUsList() {
    List<Widget> chooseUsList = [];
    for (int index = 0; index < AppConstants.whyChooseUsList.length; index++) {
      chooseUsList.add(Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
        InkWell(
          onTap: ()async{
               Get.dialog(const CustomLoader(),
                                          barrierDismissible: false);
                                      _address =
                                          await Get.find<LocationController>()
                                              .getCurrentLocation(true);
                                      _controller.text = _address!.address!;
                                if (_address != null &&
                                    _controller.text.trim().isNotEmpty) {
                                  Get.dialog(const CustomLoader(),
                                      barrierDismissible: false);
                                  ZoneResponseModel response =
                                      await Get.find<LocationController>()
                                          .getZone(
                                   '45.46532432494875',
                                   '9.167883803503045',
                                    false,
                                  );
                                  if (response.isSuccess) {
                                    Get.find<LocationController>()
                                        .saveAddressAndNavigate(
                                      _address,
                                      widget.fromSignUp,
                                      widget.route,
                                      widget.route != null,
                                      ResponsiveHelper.isDesktop(Get.context),
                                    );
                                  } else {
                                    Get.back();
                                    showCustomSnackBar(
                                        'service_not_available_in_current_location'
                                            .tr);
                                  }
                                } else {
                                  showCustomSnackBar('pick_an_address'.tr);
                                }
          },
          child: Get.find<LocalizationController>().locale!.languageCode=="en" ? LandingCard(
              icon: AppConstants.whyChooseUsList[index].icon, title: '',
              ): LandingCard(
              icon: AppConstants.whyChooseUsListIt[index].icon, title: '',
              ),
        ),
        SizedBox(
            width: index != AppConstants.whyChooseUsList.length - 1 ? 30 : 0),
      ])));
    }
    return chooseUsList;
  }
}

class CustomPath extends CustomClipper<Path> {
  final bool? isRtl;
  CustomPath({required this.isRtl});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isRtl!) {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width * 0.7, 0)
        ..lineTo(0, 0)
        ..close();
    } else {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width * 0.3, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
