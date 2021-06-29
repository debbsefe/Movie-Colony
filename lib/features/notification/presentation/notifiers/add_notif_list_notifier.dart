import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../data/models/notification_list_model.dart';
import '../../domain/usecases/add_notif_list.dart';

class AddNotifListNotifier extends GenericStateNotifier<void> {
  AddNotifListNotifier(this.addNotifList);

  final AddNotificationList addNotifList;

  void addNotification(NotificationListModel model) {
    sendRequest(() async {
      return await addNotifList(Params(model: model));
    });
  }
}
