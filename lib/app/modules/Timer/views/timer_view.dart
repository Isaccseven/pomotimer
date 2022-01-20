import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pomotimer_time_management/app/constants/colors.dart';
import 'package:pomotimer_time_management/app/modules/Timer/model/notifications.dart';

import '../controllers/timer_controller.dart';

class TimerView extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: buildHeaderRow(),
            flex: 15,
          ),
          Expanded(
            child: buildTimerCircle(),
            flex: 55,
          ),
          Expanded(
            child: SizedBox(),
            flex: 5,
          ),
          Expanded(
            child: buildPlayButton(),
            flex: 10,
          ),
          Expanded(
            child: SizedBox(),
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(),
        Row(
          children: List.generate(
            3,
            (index) => buildMethodWidget(
              index,
              getMethodName(index),
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }

  String getMethodName(int index) {
    if (index == 0) {
      return "Pomodoro";
    }
    if (index == 1) {
      return "Long Break";
    }
    if (index == 2) {
      return "Short Break";
    }
    return "";
  }

  Widget buildMethodWidget(int index, String methodName) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.handleNewTap(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1),
                BoxShadow(
                    color: GlobalColors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10),
              color: controller.activeMethod.value == index
                  ? GlobalColors.red
                  : Colors.grey.shade300,
            ),
            child: Center(
              child: Text(
                methodName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: controller.activeMethod.value == index
                        ? GlobalColors.white
                        : Colors.grey.shade500,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildTimerCircle() {
    return Obx(
      () {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                  color: GlobalColors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1)
            ],
          ),
          child: CircularCountDownTimer(
            initialDuration: 0,
            duration: controller.duration.value,
            controller: controller.countdownController.value,
            width: Get.mediaQuery.size.width * 0.8,
            height: Get.mediaQuery.size.height * 0.8,
            ringColor: GlobalColors.red,
            ringGradient: null,
            fillColor: GlobalColors.white,
            fillGradient: null,
            backgroundColor: GlobalColors.white,
            backgroundGradient: null,
            strokeWidth: 10.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
              fontSize: 45.0,
              color: GlobalColors.grey,
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.MM_SS,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              controller.isStarted.value = true;
            },
            onComplete: () {
              createBasicNotification(
                '${Emojis.time_alarm_clock} Finished',
                'Your Countdown of ${controller.formatedTime(controller.duration.value)} minutes is over',
              );
              controller.isPaused.value = false;
              controller.isStarted.value = false;
              print('Countdown Ended');
            },
          ),
        );
      },
    );
  }

  Widget buildPlayButton() {
    return Obx(
      () {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                  color: GlobalColors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1)
            ],
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: IconButton(
            onPressed: () {
              controller.counterHandler();
            },
            icon: Icon(
              controller.getIcon(),
              color: GlobalColors.grey,
              size: 50,
            ),
          ),
        );
      },
    );
  }
}
