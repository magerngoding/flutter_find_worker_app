// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/controllers/browse_controller.dart';
import 'package:flutter_coworkers_app/widgets/section_title.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  final browseController = Get.put(BrowseController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    browseController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 414,
          child: Stack(
            children: [
              Image.asset(
                'assets/bg_discover_page.png',
              ),
              Transform.translate(
                // geser paksa
                offset: Offset(0, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    header(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "Anda butuh pekerja\napa untuk hari ini?",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    categories(),
                    const SizedBox(height: 40.0),
                    searchBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50.0),
        latestStats(),
        const SizedBox(height: 30.0),
        highRatedWorkers(),
        const SizedBox(height: 30.0),
        newComers(),
        const SizedBox(height: 30.0),
        curatedTips(),
        const SizedBox(height: 30.0),
      ],
    );
  }

  Widget curatedTips() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            text: 'Curated Tips',
          ),
          Column(
            children: browseController.curatedTips.map((item) {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          item['image'],
                          width: 70.0,
                          height: 70.0,
                        ),
                        if (item['is_popular'])
                          Positioned(
                            left: 0, // mepet kiri
                            right: 0, // mepet kanan
                            bottom: 0,
                            child: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color(0XFFBFA8FF),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Popular',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          item['category'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget newComers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'Newcomers',
          autoPadding: true,
        ),
        const SizedBox(
          height: 12.0,
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // jumlah gambar genap
            mainAxisExtent: 74, // tinggi gambar
            crossAxisSpacing: 16, // spasi antar colom
            mainAxisSpacing: 16, // spasi ke bawah
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: browseController.newcomers.length,
          itemBuilder: (context, index) {
            Map item = browseController.newcomers[index];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border.all(
                  color: Color(0XFFEAEAEA),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    width: 46,
                    height: 46,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          item['job'],
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget highRatedWorkers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'High Rated Workers',
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
            itemCount: browseController.highRatedWorkers.length,
            itemBuilder: (context, index) {
              Map worker = browseController.highRatedWorkers[index];

              return Container(
                width: 100,
                margin: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == browseController.highRatedWorkers.length - 1
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

  Widget latestStats() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            text: 'Latest Stats',
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ic_hired_stats.png",
                      width: 46.0,
                      height: 46.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12,882',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Hired',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ic_money_spend.png",
                      width: 46.0,
                      height: 46.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$89, 390',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Expanse',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
                hintText: 'Search your dream worker',
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

  Widget categories() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: browseController.categories.length,
        itemBuilder: (context, index) {
          Map category = browseController.categories[index];

          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                // index di kiri ujung jarak 20
                left: index == 0 ? 20 : 0,

                // index di ujung kanan 20 jika di sebelum terakhir jaraknya 8
                right: index == browseController.categories.length - 1 ? 20 : 8,
              ),
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    category['icon'],
                    width: 46.0,
                    height: 46.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    category['label'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0XFFBFA8FF),
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Obx(
              () {
                return Text(
                  // Cara ambil nama inisial menggunakan index [0]
                  userController.data.name?[0] ?? '',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () {
                    return Text(
                      'Hi, ${userController.data.name ?? ''}',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
                Text(
                  "Recruiter",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: const Badge(
              smallSize: 10,
              backgroundColor: Colors.red,
              child: ImageIcon(
                AssetImage('assets/ic_notification.png'),
              ),
            ),
            style: const ButtonStyle(
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
