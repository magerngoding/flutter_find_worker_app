// ignore_for_file: prefer_const_constructors

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

class AppInfo {
  static toastSuccess(String message) {
    DInfo.toastSuccess(message);
  }

  static success(BuildContext context, String message) {
    /**
     -Jika pake Dinfo
     DInfo.snackBarSuccess(context, message);
     */

    // - Jika ingin custome sendiri
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  static failed(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0XFFE65556),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
