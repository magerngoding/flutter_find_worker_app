// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_coworkers_app/controllers/list_worker_controller.dart';

class ListWorkerPage extends StatefulWidget {
  final String category;

  const ListWorkerPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ListWorkerPage> createState() => _ListWorkerPageState();
}

class _ListWorkerPageState extends State<ListWorkerPage> {
  final listWorkerController = Get.put(ListWorkerController());

  @override
  void dispose() {
    listWorkerController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarCenter(widget.category),
    );
  }
}
