import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pomotimer_time_management/app/utils/notification_utils.dart';

Future<void> createBasicNotification(String title,String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: title,
      autoDismissible: true,
      displayOnBackground: true,
      wakeUpScreen: true,

      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
  );
}