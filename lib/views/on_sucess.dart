import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnSucess extends StatelessWidget {
  const OnSucess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/sucess.json", height: 200, width: 200),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Payment Successfull",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
