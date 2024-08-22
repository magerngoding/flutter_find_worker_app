import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';

class WorkerProfilePage extends StatefulWidget {
  final WorkerModel worker; // Ambildata si worker model

  const WorkerProfilePage({super.key, required this.worker});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarCenter(widget.worker.name),
    );
  }
}
