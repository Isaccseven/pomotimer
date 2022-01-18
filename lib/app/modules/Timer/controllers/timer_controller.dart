import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  var activeMethod = 0.obs;

  var isStarted = false.obs;
  var isPaused = false.obs;

  var duration = 1500.obs;

  Rx<CountDownController> countdownController = CountDownController().obs;

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    addActionStream();
  }

  @override
  void onReady() {
    duration.value = getCountDownTime();
    countdownController.value.restart(duration: getCountDownTime());
    countdownController.value.pause();
    isPaused.value = true;
    super.onReady();
  }

  void addActionStream() {
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
        Get.offNamedUntil("root", (route) => route.isFirst);
      }
    });
  }

  void requestPermissions() {
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) => {
            if (!isAllowed)
              {
                Get.defaultDialog(
                  title: 'Allow Notifications',
                  content: Text('Our app would like to send you notifications'),
                  onCancel: () => Get.back(),
                  onConfirm: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Get.back()),
                )
              },
          },
        );
  }

  // Format time for notifications
  String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString() );

    return parsedTime;
  }

  void counterHandler() {
    if (isStarted.isFalse) {
      isStarted.value = true;
      countdownController.value.restart(duration: getCountDownTime());
    } else {
      if (isPaused.isFalse) {
        countdownController.value.pause();
        isPaused.value = true;
      } else if (isPaused.isTrue) {
        isPaused.value = false;
        countdownController.value.resume();
      }
    }
  }

  // Handle changes when method is switched
  void handleNewTap(int index) {
    activeMethod.value = index;
    isStarted.value = false;
    isPaused.value = false;
    duration.value = getCountDownTime();
    countdownController.value.restart(duration: getCountDownTime());
    countdownController.value.pause();
    isPaused.value = true;
  }

  // helper for getting correct icon of playbutton
  IconData getIcon() {
    if (isStarted.isFalse) {
      return Icons.play_arrow;
    } else {
      if (isPaused.value == true) {
        return Icons.play_arrow;
      } else {
        return Icons.pause;
      }
    }
    return Icons.add;
  }

  // setup time for different methods
  int getCountDownTime() {
    switch (activeMethod.value) {
      case 0:
        return 1500;
      case 1:
        return 900;
      case 2:
        //return 300;
        return 5;
      default:
        return 0;
    }
  }
}
