import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/controllers/booking_controller.dart';
import 'package:flutter_coworkers_app/controllers/success_booking_controller.dart';
import 'package:flutter_coworkers_app/widgets/secondary_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../config/app_format.dart';

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
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bookingController.bookingDetail.worker!.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Image.asset(
                      "assets/ic_verified.png",
                      width: 20.0,
                      height: 20.0,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                rating(),
                const SizedBox(height: 60.0),
                SizedBox(
                  width: 270,
                  child: FilledButton(
                    onPressed: () {
                      successBookingController.toWorkerProfile(
                        context,
                        bookingController.bookingDetail.workerId,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: Text('Worker Profile'),
                  ),
                ),
                DView.spaceHeight(),
                SizedBox(
                  width: 270,
                  child: SecondaryButton(
                    onPressed: () {
                      successBookingController.toListWorker(
                        context,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: Text('Hired other worker'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Row rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: bookingController.bookingDetail.worker!.rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true, // bisa setengah rating
          itemCount: 5,
          itemSize: 20,
          itemPadding: EdgeInsets.all(0),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            size: 24.0,
            color: Colors.amber,
          ),
          onRatingUpdate: (value) {},
          ignoreGestures: true, // agar tidak bisa di ubah
        ),
        Text(
          '(${AppFormat.number(
            bookingController.bookingDetail.worker!.ratingCount,
          )})',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ],
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
