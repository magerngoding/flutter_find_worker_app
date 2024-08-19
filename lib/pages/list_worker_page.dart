// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_color.dart';
import 'package:flutter_coworkers_app/widgets/header_worker.dart';
import 'package:get/get.dart';

import 'package:flutter_coworkers_app/controllers/list_worker_controller.dart';

import '../widgets/section_title.dart';

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
      body: ListView(
        padding: EdgeInsets.all(0),
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
                  // geser paksa
                  offset: Offset(0, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: HeaderWorker(
                          title: widget.category,
                          subtitle: '13, 492 workers',
                          iconLeft: 'assets/ic_back.png',
                          functionLeft: () => Navigator.pop(context),
                          iconRight: 'assets/ic_filter.png',
                          functionRight: () {},
                        ),
                      ),
                      searchBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 50.0),
          topRatedCategory(),
        ],
      ),
    );
  }

  Widget topRatedCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'Top Rated ${widget.category}',
          autoPadding: true,
        ),
        const SizedBox(
          height: 12.0,
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: listWorkerController.topRated.length,
            itemBuilder: (context, index) {
              Map worker = listWorkerController.topRated[index];

              return Container(
                width: 100,
                margin: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == listWorkerController.topRated.length - 1
                      ? 20
                      : 8,
                ),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  border: Border.all(
                    color: Color(0XFFEAEAEA),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      worker['image'],
                      width: 46,
                      height: 46,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      worker['name'],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          '${worker['rate']}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget searchBox() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffe5e7ec).withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 20, right: 8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                hintStyle: TextStyle(
                  color: Color(0xffA7A8B3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage(
                'assets/ic_search.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
