import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payu_checkout_main/controller/payu_payment_controller.dart';
import 'package:payu_checkout_main/views/widgets/checkoutbtn.dart';
import 'package:payu_checkout_main/views/widgets/customtextfield.dart';

// ignore: must_be_immutable
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PayuPaymentController payuPaymentController =
      Get.put(PayuPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: const Text(
          'PayU Checkout',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Customtextfield(
                title: "Customer Name",
                errorMsg: "Please Enter Customer Name",
                textController: payuPaymentController.nameController),
            const SizedBox(height: 10),
            Customtextfield(
                title: "Customer Email",
                errorMsg: "Please Enter Customer Email",
                textController: payuPaymentController.emailController),
            const SizedBox(height: 10),
            Customtextfield(
                title: "Customer Phone",
                errorMsg: "Please Enter Customer Phone",
                textController: payuPaymentController.phoneController),
            const SizedBox(height: 10),
            Customtextfield(
                title: "Amount",
                errorMsg: "Please Enter Amount",
                textController: payuPaymentController.amountController),
            const SizedBox(height: 50),
            Checkoutbtn(
              onPress: () {
                payuPaymentController.updatePaymentParams();
                payuPaymentController.generateTxnId(13);
                payuPaymentController.initCheckoutPro();
              },
            )
          ],
        ),
      ),
    );
  }
}
