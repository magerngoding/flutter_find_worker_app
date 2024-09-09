import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/config/app_format.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/config/enums.dart';

import 'package:flutter_coworkers_app/controllers/worker_profile_controller.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:flutter_coworkers_app/widgets/secondary_button.dart';
import 'package:flutter_coworkers_app/widgets/section_title.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../controllers/user_controller.dart';
import '../widgets/header_worker.dart';

class WorkerProfilePage extends StatefulWidget {
  final WorkerModel worker; // Ambildata si worker model

  const WorkerProfilePage({super.key, required this.worker});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final workerProfileController = Get.put(WorkerProfileController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    workerProfileController.checkHiredBy(widget.worker.$id);
    super.initState();
  }

  @override
  void dispose() {
    workerProfileController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Container(
                height: 172,
                decoration: BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: HeaderWorker(
                      title: 'Worker Profile',
                      subtitle: 'Details are matters',
                      iconLeft: 'assets/ic_back.png',
                      functionLeft: () => Navigator.pop(context),
                      iconRight: 'assets/ic_other.png',
                      functionRight: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 6.0,
                            color: Colors.white,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          Appwrite.imageURL(widget.worker.image),
                          width: 136,
                          height: 136,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Obx(() {
                        String recruiterId =
                            workerProfileController.recruiterId;
                        if (recruiterId == '') return DView.nothing();
                        if (recruiterId == 'Available') return DView.nothing();
                        if (recruiterId == userController.data.$id) {
                          return hireyByYouText();
                        }
                        return hireyByOtherText();
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.worker.name,
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
                  Obx(() {
                    String recruiterId = workerProfileController.recruiterId;
                    String txtAvailable =
                        recruiterId == 'Available' ? ' • Available' : '';
                    return Text(
                      '${widget.worker.location} • ${widget.worker.experience}yrs$txtAvailable',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    );
                  }),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          SectionTitle(
            text: 'About',
            autoPadding: true,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.worker.about,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RatingBar.builder(
                  initialRating: widget.worker.rating,
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
                  '(${AppFormat.number(widget.worker.ratingCount)})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SectionTitle(
            text: 'My Strengths',
            autoPadding: true,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            children: widget.worker.strengths.map((e) {
              // ^ Parents jadi sudah mengikuti untuk berapa banyak nya
              return Padding(
                padding: EdgeInsets.only(left: 12, right: 20),
                child: Row(
                  children: [
                    Radio(
                      // Atur jarak
                      visualDensity: VisualDensity(
                        vertical: -3,
                        horizontal: -4,
                      ),
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Text(
                      e,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),

      // Logic
      bottomNavigationBar: Obx(
        () {
          String recruiterId = workerProfileController.recruiterId;
          if (recruiterId == '') {
            return UnconstrainedBox(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: DView.loadingCircle(),
              ),
            );
          }
          if (recruiterId == 'Available') {
            return hireNow();
          }
          if (recruiterId == userController.data.$id) {
            return hireByYou();
          }
          return hireByOther();
        },
      ),
    );
  }

  Widget hireByOther() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('per hour')
              ],
            ),
          ),
          SizedBox(
            width: 166,
            child: SecondaryButton(
              onPressed: () {},
              child: Text('Not Available'),
            ),
          )
        ],
      ),
    );
  }

  Widget hireByYou() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              onPressed: () {},
              child: Text('Message'),
            ),
          ),
          DView.spaceWidth(),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: Text('Give Rating'),
            ),
          ),
        ],
      ),
    );
  }

  Widget hireNow() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('per hour')
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.booking.name,
                  arguments: widget.worker,
                );
              },
              child: Text('Hire Now'),
            ),
          )
        ],
      ),
    );
  }

  Positioned hireyByYouText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0XFFBFA8FF),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: Text(
              'HIRED BY YOU',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned hireyByOtherText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0XFFFF7179),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: Text(
              'HIRED BY OTHER',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
