import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/controllers/worker_profile_controller.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:get/get.dart';

class WorkerProfilePage extends StatefulWidget {
  final WorkerModel worker; // Ambildata si worker model

  const WorkerProfilePage({super.key, required this.worker});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final workerProfileController = Get.put(WorkerProfileController());

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
      appBar: DView.appBarCenter(widget.worker.name),
    );
  }
}
