import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../controllers/booking_controller.dart';
import '../controllers/checkout_contoller.dart';
import '../controllers/user_controller.dart';
import '../widgets/header_worker_left.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final checkoutController = Get.put(CheckoutContoller());
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    checkoutController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 172,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.bgHeader,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 58),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'Checkout Worker',
                        subtitle: 'Start hiring and grow',
                        functionLeft: () {
                          Navigator.pop(context);
                        },
                        iconLeft: 'assets/ic_back.png',
                      ),
                      payment(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 90.0),
        ],
      ),
    );
  }

  Widget payment() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
          children: checkoutController.payments.map((e) {
        return Padding(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5.0,
                    color: Colors.white,
                  ),
                  color: e['is_active']
                      ? Theme.of(context).primaryColor
                      : Color(0XFFF2F2F2),
                ),
                child: Image.asset(
                  e['image']!,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                e['label'] ?? '',
                style: TextStyle(
                  color: e['is_active'] ? Colors.black : Color(0XFFA7A883),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList()),
    );
  }
}
