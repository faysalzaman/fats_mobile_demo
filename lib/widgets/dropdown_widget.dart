// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  String value;
  List<String> list;

  DropdownButtonWidget({
    super.key,
    required this.value,
    required this.list,
  });

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField(
        // Initial Value
        value: widget.value,
        isDense: true,
        isExpanded: true,
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.list.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),

        onChanged: (String? newValue) {
          setState(
            () {
              widget.value = newValue!;
            },
          );
        },
      ),
    );
  }
}
