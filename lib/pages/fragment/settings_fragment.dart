import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/enums.dart';
import 'package:flutter_coworkers_app/config/session.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  final userController = Get.put(UserController());

  logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            'You sure want to sign out?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                true,
              ),
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then(
      (yes) {
        if (yes ?? false) {
          AppSession.removeUser();
          Navigator.pushReplacementNamed(context, AppRoute.signIn.name);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 172 + 120,
          child: Stack(
            children: [
              Container(
                height: 172,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    header(),
                    DView.spaceHeight(),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 6.0,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        color: Color(
                          0XFFBFA8FF,
                        ),
                      ),
                      child: Obx(
                        () {
                          String initialName = userController.data.name == null
                              ? ""
                              // ambil karakter pertama
                              : userController.data.name!.substring(0, 1);
                          return Text(
                            initialName,
                            style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              DView.spaceHeight(),
            ],
          ),
        ),
        Center(
          child: Obx(
            () => Text(
              userController.data.name ?? '',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'Recruiter Account',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        DView.spaceHeight(),
        itemSetting('assets/ic_edit.png', 'Edit Profile'),
        itemDivider(),
        itemSetting('assets/ic_invoice.png', 'Invoices'),
        itemDivider(),
        itemSetting('assets/ic_payment_setting.png', 'Payments'),
        itemDivider(),
        itemSetting('assets/ic_notification_setting.png', 'Notification'),
        itemDivider(),
        itemSetting('assets/ic_rate_app.png', 'Rate App'),
        itemDivider(),
        itemSetting(
          'assets/ic_sign_out.png',
          'Sign Out',
          onTap: logout,
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  Widget itemDivider() {
    return Divider(
      height: 1,
      // ketebalan
      thickness: 1,
      // garis otomatis kiri / margin kiri
      indent: 20,
      // margin ke kanan
      endIndent: 20,
      color: Color(0XFFEAEAEA),
    );
  }

  Widget itemSetting(
    String icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: onTap,
      leading: ImageIcon(
        AssetImage(icon),
      ),
      title: Text(title),
      titleTextStyle: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'My Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Protect your account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
