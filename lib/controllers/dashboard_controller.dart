import 'package:d_view/d_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coworkers_app/pages/fragment/browse_fragment.dart';
import 'package:flutter_coworkers_app/pages/fragment/order_fragment.dart';
import 'package:flutter_coworkers_app/pages/fragment/settings_fragment.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  clear() {
    Get.delete<DashboardController>(force: true);
  }

  final _index = 0.obs;
  int get index => _index.value;
  set index(int n) => _index.value = n;

  // Getter ambil fragment yang aktif
  Widget get currentFragment => menu[index]['fragment'];

  List<Map> menu = [
    {
      'icon_off': 'assets/ic_browse_grey.png',
      'icon_on': 'assets/ic_browse_purple.png',
      'label': 'Browse',
      'fragment': BrowseFragment(),
    },
    {
      'icon_off': 'assets/ic_orders_grey.png',
      'icon_on': 'assets/ic_orders_purple.png',
      'label': 'Order',
      'fragment': OrderFragment(),
    },
    {
      'icon_off': 'assets/ic_wallet_grey.png',
      'icon_on': 'assets/ic_wallet_grey.png',
      'label': 'Wallet',
      'fragment': DView.empty('Wallet'),
    },
    {
      'icon_off': 'assets/ic_settings_grey.png',
      'icon_on': 'assets/ic_settings_purple.png',
      'label': 'Settings',
      'fragment': SettingsFragment(),
    },
  ];
}
