import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer_time_management/app/constants/colors.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalColors.red),
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(),
                SizedBox(
                  height: 50,
                ),
                buildPomodorSetting("Pomodoro Time", 0),
                SizedBox(height: 30),
                buildPomodorSetting("Long Break", 1),
                SizedBox(height: 30),
                buildPomodorSetting("Short Break", 2),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildPomodorSetting(String timeTitle, int index) {
    return GestureDetector(
      onTap: () => controller.updateTime(index),
      child: Container(
        height: 70,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                timeTitle,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "${controller.pomodoroTimeValue.value[index]} min",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "Settings",
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
