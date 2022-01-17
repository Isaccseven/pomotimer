import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pomotimer_time_management/app/constants/colors.dart';
import 'package:pomotimer_time_management/app/modules/Timer/views/timer_view.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      backgroundColor: Colors.grey.shade300,
      body: TimerView(),
    );
  }
}
