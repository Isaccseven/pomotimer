import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pomotimer_time_management/app/modules/Timer/controllers/timer_controller.dart';

class SettingsController extends GetxController {
  final box = GetStorage();

  RxList pomodoroTimeValue = ["25", "15", "5"].obs;
  final methodNames = ['pomodoroTime', 'longBreak', 'shortBreak'];


  @override
  void onReady() {
    pomodoroTimeValue[0] = box.read("pomodoroTime") ?? "25";
    pomodoroTimeValue[1] = box.read("longBreak") ?? "15";
    pomodoroTimeValue[2] = box.read("shortBreak") ?? "5";
    super.onReady();
  }

  void updateTime(int index) {
    Get.defaultDialog(
      title: 'Set Time',
      backgroundColor: Colors.grey.shade300,
      buttonColor: Colors.grey.shade700,
      confirmTextColor: Colors.grey.shade300,
      titleStyle: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
        fontSize: 25,
      ),
      content: TextFormField(
        cursorColor: Colors.grey.shade700,
        style: TextStyle(
          color: Colors.grey.shade700
        ),
        decoration: InputDecoration(
          focusColor: Colors.grey.shade700,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade700,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade700,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (int.parse(value) > 60) {
            pomodoroTimeValue[index] = "60";
            box.write(methodNames[index], "60");
          } else {
            pomodoroTimeValue[index] = value;
            box.write(methodNames[index], value);
          }
        },
      ),
      onConfirm: () {
        Get.back();
      },
      textConfirm: 'Ok',
    );
  }
}
