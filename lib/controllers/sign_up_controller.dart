import 'package:flutter/material.dart';
import 'package:flutter_coworkers_app/config/app_info.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  clear() {
    Get.delete<SignUpController>(force: true);
  }

  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  // untuk sign
  execute(BuildContext context) {
    // NAME
    if (editName.text == '') {
      AppInfo.failed(context, 'Nama wajib diisi!');
      return; // pakai return agar tidak ke eksekusi semua perintah nya
    }

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
  }
}
