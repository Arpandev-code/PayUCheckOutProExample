import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payu_checkout_main/views/checkout_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Get.to(() => const CheckoutScreen());
            },
            child: const Text(
              "PayU Checkout",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            )),
      ),
    );
  }
}
