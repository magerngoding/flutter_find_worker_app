import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/controllers/booking_controller.dart';
import 'package:flutter_coworkers_app/controllers/success_booking_controller.dart';
import 'package:get/get.dart';

class SuccessBookingPage extends StatefulWidget {
  const SuccessBookingPage({super.key});

  @override
  State<SuccessBookingPage> createState() => _SuccessBookingPageState();
}

class _SuccessBookingPageState extends State<SuccessBookingPage> {
  final successBookingController = Get.put(SuccessBookingController());
  final bookingController = Get.put(BookingController());

  @override
  void dispose() {
    successBookingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/blur_purple.png"),
          Image.asset("assets/blur_blue.png"),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Success Hiring",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Time to expand your business\nand grow confidently",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 6.0,
                            color: Colors.white,
                          ),
                          shape: BoxShape.circle),
                      child: Image.network(
                        Appwrite.imageURL(
                          bookingController.bookingDetail.worker!.image,
                        ),
                        width: 136.0,
                        height: 136.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    hiredText(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget hiredText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: Offset(0, 6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Color(0XFFBFA8FF),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Text(
              'HIRED',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
