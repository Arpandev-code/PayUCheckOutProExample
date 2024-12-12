import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';

import '../services/hash_service.dart';
import '../views/on_sucess.dart';

class PayuPaymentController extends GetxController
    implements PayUCheckoutProProtocol {
  RxBool isLoading = false.obs;

  //! TextEditingControllers for payment details
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  //! Payment Details Variables required for PayU Gateway
  late Map<dynamic, dynamic> payUPaymentParams;
  late PayUCheckoutProFlutter _checkoutPro;
  late var txnId = "".obs;
  static final merchantSecretKey = dotenv.env['MERCHANTSALTKEY'];

  @override
  void onInit() {
    super.onInit();
    txnId.value = generateTxnId(13);
    _checkoutPro = PayUCheckoutProFlutter(this);
    //! Initialize payUPaymentParams in onInit method
    payUPaymentParams = {
      PayUPaymentParamKey.key: merchantSecretKey,
      PayUPaymentParamKey.amount: amountController.text.toString(),
      PayUPaymentParamKey.productInfo: "Test Product",
      PayUPaymentParamKey.firstName: nameController.text.toString(),
      PayUPaymentParamKey.email: emailController.text.toString(),
      PayUPaymentParamKey.phone: phoneController.text.toString(),
      PayUPaymentParamKey.environment: "1",
      // String - "0" for Production and "1" for Test
      PayUPaymentParamKey.transactionId: txnId.toString(),
      // transactionId Cannot be null or empty and should be unique for each transaction.
      // Maximum allowed length is 25 characters. It cannot contain special characters like: -_/
      PayUPaymentParamKey.userCredential: "9let8O:1000",
      //  Format: <merchantKey>:<userId> ... UserId is any id/email/phone number to uniquely identify the user.
      PayUPaymentParamKey.android_surl:
          "https:///www.payumoney.com/mobileapp/payumoney/success.php",
      PayUPaymentParamKey.android_furl:
          "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
      PayUPaymentParamKey.ios_surl:
          "https:///www.payumoney.com/mobileapp/payumoney/success.php",
      PayUPaymentParamKey.ios_furl:
          "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
    };
  }

  //!Config Data
  final Map<dynamic, dynamic> payUCheckoutProConfig = {
    PayUCheckoutProConfigKeys.merchantName: "PayU",
    // PayUCheckoutProConfigKeys.waitingTime:"30"
  };
  //! generate txn id
  String generateTxnId(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }

  //! Method to update payment parameters dynamically
  void updatePaymentParams() {
    payUPaymentParams[PayUPaymentParamKey.amount] = amountController.text;
    payUPaymentParams[PayUPaymentParamKey.firstName] = nameController.text;
    payUPaymentParams[PayUPaymentParamKey.email] = emailController.text;
    payUPaymentParams[PayUPaymentParamKey.phone] = phoneController.text;
  }

  @override
  generateHash(Map response) {
    // Pass response param to your backend server
    // Backend will generate the hash which you need to pass to SDK
    // hashResponse: is the response which you get from your server
    Map hashResponse = HashService.generateHash(response);
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  //!On Sucess Methods
  @override
  onPaymentSuccess(dynamic response) {
    response.forEach((key, value) {
      Get.to(() => const OnSucess());
    });
  }

  //!On Payment Failure
  @override
  onPaymentFailure(dynamic response) {
    response.forEach((key, value) {
      print("$key: $value");
    });
  }

  //!On Payment Cancel
  @override
  onPaymentCancel(Map? response) {
//Handle on cancel response
    response?.forEach((key, value) {
      print("$key: $value");
    });
  }

  //!On Error
  @override
  onError(Map? response) {
    response?.forEach((key, value) {
      print("$key: $value");
    });
  }

  //!Init Payment
  void initCheckoutPro() {
    try {
      isLoading.value = true;
      _checkoutPro.openCheckoutScreen(
          payUPaymentParams: payUPaymentParams,
          payUCheckoutProConfig: payUCheckoutProConfig);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }
}
