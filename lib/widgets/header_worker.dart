// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class HeaderWorker extends StatelessWidget {
  final String title;
  final String subtitle;

  final VoidCallback functionRight;
  final String iconRight;
  final VoidCallback functionLeft;
  final String iconLeft;

  const HeaderWorker({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.functionRight,
    required this.iconRight,
    required this.functionLeft,
    required this.iconLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton.filled(
            onPressed: functionLeft,
            icon: ImageIcon(AssetImage(iconLeft)),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          IconButton.filled(
            onPressed: functionRight,
            icon: ImageIcon(AssetImage(iconRight)),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}