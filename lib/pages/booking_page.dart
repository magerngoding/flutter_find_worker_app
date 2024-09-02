// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/config/app_color.dart';
import 'package:flutter_coworkers_app/config/app_format.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/config/enums.dart';
import 'package:flutter_coworkers_app/controllers/booking_controller.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';

import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:flutter_coworkers_app/widgets/header_worker_left.dart';
import 'package:flutter_coworkers_app/widgets/section_title.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          ),
          const SizedBox(height: 90.0),
          selectDuration(),
          const SizedBox(height: 30.0),
          whenYouNeed(),
          const SizedBox(height: 30.0),
          details(),
          const SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.checkout.name);
              },
              child: Text('Proceed Checkout'),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget details() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(text: 'Details'),
          Obx(() {
            return itemDetail(
              'Hiring Duration',
              '${bookingController.duration} hours',
            );
          }),
          itemDetail(
            'Date',
            DateFormat('dd MMM yyyy')
                .format(bookingController.bookingDetail.date),
          ),
          GetBuilder<BookingController>(builder: (_) {
            return itemDetail(
              'Sub ',
              AppFormat.price(_.bookingDetail.subtotal),
            );
          }),
          itemDetail(
            'Insurnace',
            AppFormat.price(bookingController.bookingDetail.insurance),
          ),
          itemDetail(
            'Tax 14%',
            AppFormat.price(bookingController.bookingDetail.tax),
          ),
          itemDetail(
            'Platform fee',
            AppFormat.price(bookingController.bookingDetail.platformFee),
          ),
          itemDetail(
            'Grand total',
            AppFormat.price(bookingController.bookingDetail.grandTotal),
          ),
        ],
      ),
    );
  }

  Widget itemDetail(String title, String data) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget whenYouNeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'When you need?',
          autoPadding: true,
        ),
        DView.spaceHeight(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/ic_clock.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                    ),
                  ],
                ),
              ),
              Radio(
                // 1-1 / true-true agar di baca match aktif
                value: 1,
                groupValue: 1,
                visualDensity: VisualDensity(horizontal: -4),
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget selectDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'How many hours?',
          autoPadding: true,
        ),
        DView.spaceHeight(),
        SizedBox(
          height: 100,
          child: Obx(
            () {
              int durationSelected = bookingController.duration;
              return ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: bookingController.hourDuration.last,
                itemBuilder: (context, index) {
                  int itemDuration = bookingController.hourDuration[index];

                  return GestureDetector(
                    onTap: () {
                      bookingController.setDuration(
                          itemDuration, widget.worker.hourRate);
                    },
                    child: itemDuration == durationSelected
                        ? itemDurationSelected(itemDuration)
                        : itemDurationUnSelected(itemDuration),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Container itemDurationUnSelected(int itemDuration) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.border,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(28.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${itemDuration}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Hours',
          )
        ],
      ),
    );
  }

  Container itemDurationSelected(int itemDuration) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(28.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${itemDuration}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Hours',
            style: TextStyle(
              color: Colors.white,
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
