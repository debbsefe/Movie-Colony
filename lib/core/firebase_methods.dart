import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/notification/data/models/notification_list_model.dart';
import 'utils/strings.dart';

class FirebaseMethods {
  FirebaseMethods({required this.store, required this.auth});

  final FirebaseFirestore store;
  final FirebaseAuth auth;

  DocumentReference<NotificationListModel> writeNotificationList({
    required String docName,
  }) {
    final userId = auth.currentUser?.uid;
    final reference = FirebaseFirestore.instance
        .collection(Strings.notificationList)
        .doc(userId)
        .collection('tv')
        .doc(docName)
        .withConverter<NotificationListModel>(
          fromFirestore: (snapshot, _) =>
              NotificationListModel.fromJson(snapshot.data()!),
          toFirestore: (tv, _) => tv.toJson(),
        );
    return reference;
  }

  CollectionReference<NotificationListModel> readNotificationList() {
    final userId = auth.currentUser?.uid;
    final reference = FirebaseFirestore.instance
        .collection(Strings.notificationList)
        .doc(userId)
        .collection('tv')
        .withConverter<NotificationListModel>(
          fromFirestore: (snapshot, _) =>
              NotificationListModel.fromJson(snapshot.data()!),
          toFirestore: (tv, _) => tv.toJson(),
        );
    return reference;
  }
}
