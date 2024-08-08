// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/controllers/sign_up_controller.dart';
import 'package:flutter_coworkers_app/widgets/input_auth.dart';
import 'package:flutter_coworkers_app/widgets/input_auth_password.dart';
import 'package:flutter_coworkers_app/widgets/secondary_button.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpController = Get.put(SignUpController());

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
                          "New account",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text("Let's gro your business today"),
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
                  title: 'Complete Name',
                  hint: 'Write your name',
                  editingController: signUpController.editName,
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'I agree with terms and condirion',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                FilledButton(
                  onPressed: () {
                    signUpController.execute(context);
                  },
                  child: Text(
                    'Sign Up',
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SecondaryButton(
                  onPressed: () {},
                  child: Text(
                    'Sign In to My Account',
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
