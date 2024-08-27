// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_coworkers_app/models/worker_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
