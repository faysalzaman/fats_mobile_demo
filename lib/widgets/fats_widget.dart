import 'package:fats_mobile_demo/constants.dart';
import 'package:flutter/material.dart';

class FatsWidget extends StatelessWidget {
  const FatsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Constant.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Constant.primaryColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/logo/app_icon.png',
            height: MediaQuery.of(context).size.height * 0.2,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            "Fixed Asset Tracking Software v.2.0",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
