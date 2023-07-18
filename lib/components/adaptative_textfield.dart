import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  //const AdaptativeTextField({super.key});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  final String? label;

  const AdaptativeTextField({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 11,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
