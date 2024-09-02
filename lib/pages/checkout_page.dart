import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/config/app_format.dart';
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
          Transform.translate(
            offset: Offset(0, 55),
            child: walletBox(),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Total pay",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Obx(() {
                return Text(
                  AppFormat.price(bookingController.bookingDetail.grandTotal),
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  'I agree with terms and condirion',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              if (checkoutController.loading) return DView.loadingCircle();
              return FilledButton.icon(
                onPressed: () {
                  checkoutController.execute(
                      context, bookingController.bookingDetail);
                },
                icon: ImageIcon(
                  AssetImage('assets/ic_secure.png'),
                ),
                label: Text('Pay Now'),
              );
            }),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              'Read Terms & Condition',
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                color: Color(0XFFB2B3BC),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget walletBox() {
    return Stack(
      children: [
        Image.asset(
          "assets/bg_card.png",
        ),
        Positioned(
          left: 60,
          top: 110,
          child: Text(
            AppFormat.price(78555),
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 60,
          right: 60,
          bottom: 106,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Text(
                  userController.data.name ?? '',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                );
              }),
              Text(
                "12/27",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
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
