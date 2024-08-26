import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';

import 'package:flutter_coworkers_app/controllers/worker_profile_controller.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';
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
          SizedBox(
            child: Stack(
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
                          if (recruiterId == 'Available')
                            return DView.nothing();
                          if (recruiterId == userController.data.$id) {
                            return Text('hired by you');
                          }
                          return Text('hired by other');
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
          ),
        ],
      ),
    );
  }
}
