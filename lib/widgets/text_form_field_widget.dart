import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Color? color;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  const TextFormFieldWidget({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.labelText,
    required this.controller,
    this.readOnly,
    this.validator,
    this.color,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      height: height ?? 45,
      child: TextFormField(
        readOnly: readOnly ?? false,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: color ?? Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabled: true,
        ),
      ),
    );
  }
}
