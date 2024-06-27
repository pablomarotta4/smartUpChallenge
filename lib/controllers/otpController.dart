import 'package:get/get.dart';
import 'package:smartup_challenge/repository/userRepository.dart';

class OtpController extends GetxController {
  static OtpController get to => Get.find();
  
  void verifyOtp(String otp) async {
    var isVerified = await UserRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAllNamed('/home') : Get.back();
  }
}