// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_color.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';
import 'package:flutter_coworkers_app/config/enums.dart';
import 'package:flutter_coworkers_app/config/session.dart';
import 'package:flutter_coworkers_app/models/worker_model.dart';
import 'package:flutter_coworkers_app/pages/booking_page.dart';
import 'package:flutter_coworkers_app/pages/dashboard.dart';
import 'package:flutter_coworkers_app/pages/get_started_page.dart';
import 'package:flutter_coworkers_app/pages/list_worker_page.dart';
import 'package:flutter_coworkers_app/pages/sign_in_page.dart';
import 'package:flutter_coworkers_app/pages/sign_up_page.dart';
import 'package:flutter_coworkers_app/pages/worker_profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Appwrite.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: AppColor.text,
          displayColor: AppColor.text,
        ),
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.light(
          primary: AppColor.primary,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
              Size.fromHeight(52),
            ),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      initialRoute: AppRoute.dashboard.name,
      routes: {
        AppRoute.getStarted.name: (context) => GetStartedPage(),
        AppRoute.signUp.name: (context) => SignUpPage(),
        AppRoute.signIn.name: (context) => SignInPage(),
        AppRoute.dashboard.name: (context) {
          return FutureBuilder(
            future: AppSession.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DView.loadingCircle();
              }
              if (snapshot.data == null) {
                return GetStartedPage();
              }
              return Dashboard();
            },
          );
        },
        AppRoute.listWorker.name: (context) {
          String category =
              ModalRoute.of(context)!.settings.arguments as String;

          return ListWorkerPage(category: category);
        },
        AppRoute.workerProfile.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;

          return WorkerProfilePage(
            worker: worker,
          );
        },
        AppRoute.booking.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;

          return BookingPage(
            worker: worker,
          );
        },
      },
    );
  }
}
