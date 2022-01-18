import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pomotimer_time_management/app/constants/colors.dart';
import 'package:pomotimer_time_management/app/modules/Timer/views/timer_view.dart';
import 'package:pomotimer_time_management/app/modules/settings/views/settings_view.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        actions: [
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.settings),
            color: Colors.grey.shade500,
            onPressed: () => Get.toNamed("/settings"),
          ),
          SizedBox(width: 5,),
        ],
      ),
      body: TimerView(),
    );
  }
}
