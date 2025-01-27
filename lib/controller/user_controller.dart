import 'dart:typed_data';

import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/cart_controller.dart';
import 'package:farmacie_stilo/controller/wishlist_controller.dart';
import 'package:farmacie_stilo/data/api/api_checker.dart';
import 'package:farmacie_stilo/data/model/response/conversation_model.dart';
import 'package:farmacie_stilo/data/model/response/response_model.dart';
import 'package:farmacie_stilo/data/repository/user_repo.dart';
import 'package:farmacie_stilo/data/model/response/userinfo_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmacie_stilo/helper/network_info.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  UserInfoModel? _userInfoModel;
  XFile? _pickedFile;
  Uint8List? _rawFile;
  bool _isLoading = false;

  UserInfoModel? get userInfoModel => _userInfoModel;
  XFile? get pickedFile => _pickedFile;
  Uint8List? get rawFile => _rawFile;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {
    _pickedFile = null;
    _rawFile = null;
    ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body);
      int? userId = _userInfoModel?.id;
      String? names = _userInfoModel?.fName;
       String? emails = _userInfoModel?.email;
      print(userId);
      if (userId != null) {
        userRepo.saveId(userId,names,emails);
      }
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserInfo(
      UserInfoModel updateUserModel, String token) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response =
        await userRepo.updateProfile(updateUserModel, _pickedFile, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(true, response.bodyString);
      _pickedFile = null;
      _rawFile = null;
      getUserInfo();
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      String? message = response.body["message"];
      responseModel = ResponseModel(true, message);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    update();
    return responseModel;
  }

  void updateUserWithNewData(User? user) {
    _userInfoModel!.userInfo = user;
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = await NetworkInfo.compressImage(_pickedFile!);
      _rawFile = await _pickedFile!.readAsBytes();
    }
    update();
  }

  void initData() {
    _pickedFile = null;
    _rawFile = null;
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      showCustomSnackBar('your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.find<CartController>().clearCartList();
      Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
  }
}
