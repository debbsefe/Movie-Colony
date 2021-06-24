import '../../domain/repositories/notif_list_repository.dart';
import '../datasources/notif_list_remote_data_source.dart';
import '../models/notification_list_model.dart';

class NotifListRepositoryImpl implements NotifListRepository {
  NotifListRepositoryImpl({
    required this.remoteDataSource,
  });
  final NotifListRemoteDataSource remoteDataSource;

  @override
  Stream<List<NotificationListModel>> notificationList() {
    return remoteDataSource.notifListRemote();
  }
}
