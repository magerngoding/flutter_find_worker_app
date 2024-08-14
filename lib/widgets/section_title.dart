// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final bool autoPadding;

  const SectionTitle({
    Key? key,
    required this.text,
    this.autoPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: autoPadding
          ? EdgeInsets.symmetric(horizontal: 20)
          : EdgeInsets.all(0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
