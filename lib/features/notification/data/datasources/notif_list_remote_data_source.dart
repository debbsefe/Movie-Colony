import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/firebase_methods.dart';
import '../models/notification_list_model.dart';

abstract class NotifListRemoteDataSource {
  Stream<List<NotificationListModel>> notifListRemote();
}

class NotifListRemoteDataSourceImpl implements NotifListRemoteDataSource {
  NotifListRemoteDataSourceImpl({required this.methods});
  final FirebaseMethods methods;

  @override
  Stream<List<NotificationListModel>> notifListRemote() {
    try {
      var reference = methods.readNotificationList();

      return reference.snapshots().map(_notificationListFromSnapshot);
    } catch (e) {
      throw ServerException();
    }
  }

  List<NotificationListModel> _notificationListFromSnapshot(
      QuerySnapshot<NotificationListModel> snapshot) {
    return snapshot.docs.map((doc) {
      return NotificationListModel(
        id: doc.data().id,
        name: doc.data().name,
        date: doc.data().date,
        posterImage: doc.data().posterImage,
        rating: doc.data().rating,
      );
    }).toList();
  }
}
