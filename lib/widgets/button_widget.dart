import 'package:fats_mobile_demo/constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final double? width;
  final double? height;
  final Function onPressed;
  final double? fontSize;
  final Color? color;

  const ButtonWidget({
    super.key,
    required this.title,
    this.width,
    this.height,
    required this.onPressed,
    this.fontSize,
    this.color,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.color ?? Constant.primaryColor,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: widget.color ?? Colors.white,
      ),
      child: InkWell(
        onTap: () => widget.onPressed(),
        child: Center(
          child: FittedBox(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize ?? 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
