import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_info.dart';
import 'package:get/get.dart';

import '../datasource/user_datasource.dart';

class SignInController extends GetxController {
  clear() {
    Get.delete<SignInController>(force: true);
  }

  final editEmail = TextEditingController();
  final editPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  // untuk sign
  execute(BuildContext context) {
    // EMAIL
    if (editEmail.text == '') {
      AppInfo.failed(context, 'Email wajib diisi!');
      return;
    }

    if (!GetUtils.isEmail(editEmail.text)) {
      // Jika email tidak valid
      AppInfo.failed(context, 'Email tidak valid!');
      return;
    }

    // PASSWORD
    if (editPassword.text == '') {
      AppInfo.failed(context, 'Password wajib diisi!');
      return;
    }
    if (editPassword.text.length < 8) {
      AppInfo.failed(context, 'Password minimal 8 karakter!');
      return;
    }

    loading = true;

    UserDatasource.signIn(
      editEmail.text,
      editPassword.text,
    ).then((value) {
      loading = false;
      value.fold(
        (message) {
          AppInfo.failed(context, message);
        },
        (data) {
          AppInfo.toastSuccess('Berhasil');
          // Save to seesion
          // Navigasi
        },
      );
    });
  }
}
