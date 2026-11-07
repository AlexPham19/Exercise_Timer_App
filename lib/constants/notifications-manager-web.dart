// Mobile scheduled notifications are not available in a browser.
class NotificationsManager {
  NotificationsManager.init();
  Future<void> showNotificationOneTime(int hour, int minute) async {}
}
void cancelAllNotification() {}
