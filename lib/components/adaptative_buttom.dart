import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButtom extends StatelessWidget {
  final Function() onPressed;

  const AdaptativeButtom(
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Icon(
              CupertinoIcons.check_mark_circled,
              size: 50,
              color: Colors.green,
            ),
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.save_as_outlined),
            color: Colors.green,
          );
  }
}
