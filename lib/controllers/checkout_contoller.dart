import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_info.dart';
import '../datasource/booking_datasource.dart';
import '../models/booking_model.dart';

class CheckoutContoller extends GetxController {
  clear() {
    Get.delete<CheckoutContoller>(force: true);
  }

  final List<Map<String, dynamic>> payments = [
    {
      'image': 'assets/ic_wallet_payment.png',
      'label': 'Wallet',
      'is_active': true,
    },
    {
      'image': 'assets/ic_master_card.png',
      'label': 'CC',
      'is_active': false,
    },
    {
      'image': 'assets/ic_paypal.png',
      'label': 'Paypal',
      'is_active': false,
    },
    {
      'image': 'assets/ic_other.png',
      'label': 'Other',
      'is_active': false,
    },
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  execute(BuildContext context, BookingModel bookingDetail) {
    BookingDatasource.checkout(bookingDetail).then((value) {
      value.fold(
        (message) => AppInfo.failed(context, message),
        (data) {
          AppInfo.success(context, 'Berhasil');
        },
      );
    });
  }
}
