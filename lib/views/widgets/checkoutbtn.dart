import 'package:flutter/material.dart';

class Checkoutbtn extends StatelessWidget {
  void Function()? onPress;
  Checkoutbtn({
    super.key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.green,
        minimumSize: const Size(200, 50),
      ),
      icon: const Icon(Icons.payment),
      label: const Text(
        'Pay Now',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPress,
    );
  }
}
