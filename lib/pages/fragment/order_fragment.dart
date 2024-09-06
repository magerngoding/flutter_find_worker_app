import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/controllers/fragments/order_controller.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';
import 'package:flutter_coworkers_app/models/booking_model.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 172,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  header(),
                  DView.spaceHeight(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: menuOrder('In Progress'),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Expanded(
                          child: menuOrder('Completed'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        DView.spaceHeight(24),
        Expanded(
          child: Obx(() {
            return IndexedStack(
              index: orderController.selected == 'In Progress' ? 0 : 1,
              children: [
                inProgressList(),
                completedList(),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget completedList() {
    return Obx(
      () {
        String statusFetch = orderController.statusCompleted;
        if (statusFetch == '') return DView.nothing();
        if (statusFetch == 'Loading') return DView.loadingCircle();
        if (statusFetch != 'Success') return DView.error();

        List<BookingModel> list = orderController.completed;
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            BookingModel booking = list[index];
            WorkerModel worker = booking.worker!;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border.all(
                  color: Color(0XFFEAEAEA),
                ),
              ),
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Image.network(
                    Appwrite.imageURL(worker.image),
                    width: 60.0,
                    height: 60.0,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worker.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          worker.category,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        booking.hiringDuration.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text('hours'),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget inProgressList() {
    return Obx(
      () {
        String statusFetch = orderController.statusInProgress;
        if (statusFetch == '') return DView.nothing();
        if (statusFetch == 'Loading') return DView.loadingCircle();
        if (statusFetch != 'Success') return DView.error();

        List<BookingModel> list = orderController.inProgress;
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            BookingModel booking = list[index];
            WorkerModel worker = booking.worker!;

            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  border: Border.all(
                    color: Color(0XFFEAEAEA),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Image.network(
                      Appwrite.imageURL(worker.image),
                      width: 60.0,
                      height: 60.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            worker.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            worker.category,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          booking.hiringDuration.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text('hours'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget menuOrder(String title) {
    return GestureDetector(
      onTap: () {
        orderController.selected = title;
      },
      child: Obx(() {
        bool isActive = orderController.selected == title;
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0XFFE5E7EC).withOpacity(0.5),
                blurRadius: 30,
                offset: Offset(0, 30),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        );
      }),
    );
  }

  Padding header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Workers',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '13, 492 transactions',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage('assets/ic_search.png'),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage('assets/ic_filter.png'),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
