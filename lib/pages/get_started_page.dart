// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/enums.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    const getStarted1 = [
      'assets/gstarted1.png',
      'assets/gstarted2.png',
      'assets/gstarted3.png',
    ];
    const getStarted2 = [
      'assets/gstarted4.png',
      'assets/gstarted5.png',
      'assets/gstarted6.png',
    ];
    const getStarted3 = [
      'assets/gstarted7.png',
      'assets/gstarted8.png',
      'assets/gstarted9.png',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(), // agar tidak bisa di scroll
        reverse: true, // halaman dibuka dari bagian bawah
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageStarted(getStarted1),
            const SizedBox(height: 20.0),
            imageStarted(getStarted2),
            const SizedBox(height: 20.0),
            imageStarted(getStarted3),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Cari perkarja untuk\npertumbuhan bisnis",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF13162F),
                  height: 1.5, // jarak antar text
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Kami menyediakan berbagai jenis\npekerja siap untuk membantu Anda",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFA7A883),
                  height: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.signIn.name,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore More'),
                    ImageIcon(
                      AssetImage(
                        'assets/ic_white_arrow_right.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageStarted(List images) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
            children: images.map(
          (e) {
            return Padding(
              padding: EdgeInsets.only(right: 20),
              child: Image.asset(
                e,
                fit: BoxFit.cover,
                height: 190,
              ),
            );
          },
        ).toList()),
      ),
    );
  }
}
