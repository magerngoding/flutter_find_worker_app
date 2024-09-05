import 'package:flutter_coworkers_app/datasource/booking_datasource.dart';
import 'package:flutter_coworkers_app/models/booking_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  clear() {
    Get.delete<OrderController>(force: true);
  }

  final _selected = 'In Progress'.obs;
  String get selected => _selected.value;
  set selected(String n) => _selected.value = n;

  final _inProgress = <BookingModel>[].obs;
  List<BookingModel> get inProgress => _inProgress;

  final _completed = <BookingModel>[].obs;
  List<BookingModel> get completed => _completed;

  final _statusInProgress = ''.obs;
  String get statusInProgress => _statusInProgress.value;
  set statusInProgress(String n) => _statusInProgress.value = n;

  final _statusCompleted = ''.obs;
  String get statusCompleted => _statusCompleted.value;
  set statusCompleted(String n) => _statusCompleted.value = n;

  init(String userId) {
    fetchInProgress(userId);
    fetchInCompleted(userId);
  }

  fetchInProgress(String userId) {
    statusInProgress = 'Loading';
    BookingDatasource.fetchOrder(userId, 'In Progress').then(
      (value) {
        value.fold(
          (message) => statusInProgress = message,
          (data) {
            statusInProgress = 'Success';
            _inProgress.value = data;
          },
        );
      },
    );
  }

  fetchInCompleted(String userId) {
    statusCompleted = 'Loading';
    BookingDatasource.fetchOrder(userId, 'Completed').then(
      (value) {
        value.fold(
          (message) => statusCompleted = message,
          (data) {
            statusCompleted = 'Success';
            _completed.value = data;
          },
        );
      },
    );
  }

  setCompletrd() {}
}
