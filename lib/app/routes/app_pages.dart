import 'package:get/get.dart';

import '../modules/Timer/bindings/timer_binding.dart';
import '../modules/Timer/views/timer_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
      bindings: [
        RootBinding(),
        TimerBinding(),
      ],
    ),
    GetPage(
      name: _Paths.TIMER,
      page: () => TimerView(),
      binding: TimerBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
