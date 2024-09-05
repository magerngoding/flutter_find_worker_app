import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/controllers/fragments/order_controller.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';
import 'package:get/get.dart';

class OrderFragment extends StatefulWidget {
  const OrderFragment({super.key});

  @override
  State<OrderFragment> createState() => _OrderFragmentState();
}

class _OrderFragmentState extends State<OrderFragment> {
  final orderController = Get.put(OrderController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    orderController.init(userController.data.$id!);
    super.initState();
  }

  @override
  void dispose() {
    orderController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
