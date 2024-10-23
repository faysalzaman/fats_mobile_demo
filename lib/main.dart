import 'package:fats_mobile_demo/cubit/barcode/barcode_cubit.dart';
import 'package:fats_mobile_demo/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FATS Mobile Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
