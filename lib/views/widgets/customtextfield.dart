import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final String title;
  final String errorMsg;
  final TextEditingController textController;
  const Customtextfield(
      {super.key,
      required this.title,
      required this.errorMsg,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return null;
      },
    );
  }
}
