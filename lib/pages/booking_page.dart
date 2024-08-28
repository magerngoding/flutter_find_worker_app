// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_color.dart';
import 'package:flutter_coworkers_app/config/app_format.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/controllers/booking_controller.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';

import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:flutter_coworkers_app/widgets/header_worker_left.dart';
import 'package:get/get.dart';

class BookingPage extends StatefulWidget {
  final WorkerModel worker; // ambil data
  const BookingPage({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    bookingController.initBookingDetail(
      userController.data.$id!,
      widget.worker,
    );
    super.initState();
  }

  @override
  void dispose() {
    bookingController.clear();
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
                  decoration: BoxDecoration(
                    color: AppColor.bgHeader,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'Booking Worker',
                        subtitle: 'Grow your business today',
                        functionLeft: () {
                          Navigator.pop(context);
                        },
                        iconLeft: 'assets/ic_back.png',
                      ),
                      worker(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget worker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(
                Appwrite.imageURL(widget.worker.image),
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.worker.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Image.asset(
                          "assets/ic_verified.png",
                          width: 16.0,
                          height: 16.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/ic_star_small.png",
                          width: 16.0,
                          height: 16.0,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          widget.worker.rating.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Row(
                children: [
                  Text(
                    AppFormat.price(
                      widget.worker.hourRate,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('/hr')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
