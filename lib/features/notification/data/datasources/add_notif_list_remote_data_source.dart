import '../../../../core/error/exception.dart';
import '../../../../core/firebase_methods.dart';
import '../models/notification_list_model.dart';

abstract class AddNotifListRemoteDataSource {
  Future<void> addNotifListRemote(NotificationListModel model);
}

class AddNotifListRemoteDataSourceImpl implements AddNotifListRemoteDataSource {
  AddNotifListRemoteDataSourceImpl({required this.methods});
  final FirebaseMethods methods;

  @override
  Future<void> addNotifListRemote(NotificationListModel model) async {
    try {
      var reference = methods.writeNotificationList(
        docName: model.id.toString(),
      );
      await reference.set(model);
    } catch (e) {
      throw ServerException();
    }
  }
}
