import '../../data/models/notification_list_model.dart';

abstract class NotifListRepository {
  Stream<List<NotificationListModel>> notificationList();
}
