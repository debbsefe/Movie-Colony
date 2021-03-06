import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Config {
  Future<String> fetchToken(String value);
}

class ConfigImpl implements Config {
  ConfigImpl(this.store);

  ///fetch token from store
  final FirebaseFirestore store;
  String? _token;
  String? get token => _token;

  @override
  Future<String> fetchToken(String value) async {
    if (token == null) {
      DocumentSnapshot snapshot =
          await store.collection('token').doc(value).get();
      Map<String, dynamic> snap = snapshot.data() as Map<String, dynamic>;
      _token = snap['key'];
      return snap['key'];
    }

    return token!;
  }
}
