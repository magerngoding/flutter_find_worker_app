import 'package:get/get.dart';

class WorkerProfileController extends GetxController {
  clear() {
    Get.delete<WorkerProfileController>(force: true);
  }

  // Recruiter
  final _recruiterId = ''.obs;
  String get recruiterId => _recruiterId.value;
  set recruiterId(String n) => _recruiterId.value;

  checkHireBy(String workerId) {}
}
