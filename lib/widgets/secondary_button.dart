// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_color.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const SecondaryButton({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          AppColor.btnSecondary,
        ),
        foregroundColor: MaterialStatePropertyAll(
          Colors.black,
        ),
      ),
      child: child,
    );
  }
}
