import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:payu_checkout_main/views/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DotEnv dotenv = DotEnv();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Home(),
    );
  }
}
