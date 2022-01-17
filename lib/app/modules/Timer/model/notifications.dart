import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pomotimer_time_management/app/utils/notification_utils.dart';

Future<void> createBasicNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
      '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}