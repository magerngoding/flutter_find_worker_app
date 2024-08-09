// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/controllers/sign_in_controller.dart';
import 'package:flutter_coworkers_app/widgets/input_auth.dart';
import 'package:flutter_coworkers_app/widgets/input_auth_password.dart';
import 'package:flutter_coworkers_app/widgets/secondary_button.dart';
import 'package:get/get.dart';

import '../config/enums.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signUpController = Get.put(SignInController());

  @override
  void dispose() {
    signUpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          AspectRatio(
            // bungkus sama rata agar logo ke tengah bawah
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand, // mengikuti aspect ratio
              children: [
                Image.asset(
                  "assets/signin_background.png",
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Image.asset(
                    "assets/applogo.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Transform.translate(
                    // untuk memaksa geser 10px ke bawah
                    offset: Offset(0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text("Manage your worker!"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                InputAuth(
                  title: 'Email Address',
                  hint: 'Write your email',
                  editingController: signUpController.editEmail,
                ),
                InputAuthPassword(
                  title: 'Password',
                  hint: 'Write your password',
                  editingController: signUpController.editPassword,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Obx(() {
                  bool loading = signUpController.loading;
                  if (loading) return DView.loadingCircle();
                  return FilledButton(
                    onPressed: () {
                      signUpController.execute(context);
                    },
                    child: Text(
                      'Sign In & Explore',
                    ),
                  );
                }),
                const SizedBox(
                  height: 15.0,
                ),
                SecondaryButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.signUp.name,
                    );
                  },
                  child: Text(
                    'Create New Account',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
