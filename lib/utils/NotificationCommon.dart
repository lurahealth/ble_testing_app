import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationCommon{
  static final NotificationCommon _singleton = new NotificationCommon._internal();

  NotificationCommon._internal();

  factory NotificationCommon() {
    return _singleton;
  }

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin{
    return new FlutterLocalNotificationsPlugin();
  }

  static NotificationDetails notificationDetails() {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        StringUtils.CHANNEL_ID, StringUtils.CHANNEL_NAME,
        StringUtils.CHANNEL_DESCRIPTION,
        importance: Importance.Default, priority: Priority.Default, icon: 'mipmap/ic_launcher');
    final IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
    return NotificationDetails(androidPlatformChannelSpecifics,
                               iOSPlatformChannelSpecifics);
  }


}