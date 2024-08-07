import 'package:d_session/d_session.dart';
import 'package:flutter_coworkers_app/controllers/user_controller.dart';
import 'package:flutter_coworkers_app/models/user_model.dart';
import 'package:get/get.dart';

class AppSession {
  static Future<bool> setUser(Map user) async {
    bool success = await DSession.setUser(user as Map<String, dynamic>);

    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(user));
    }

    return success;
  }

  static Future<Map?> getUser(Map user) async {
    Map? mapUser = await DSession.getUser();

    if (mapUser != null) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(user));
    }

    return mapUser;
  }

  static Future<bool> removeUser(Map user) async {
    bool success = await DSession.removeUser();

    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel();
    }

    return success;
  }
}