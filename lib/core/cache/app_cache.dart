import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/strings.dart';

abstract class AppCache {
  ///check if the date is expired by comparing with current date.
  ///If current date is after expiry date return true, else return false
  bool isExpired(String key);

  ///save string to storage
  Future<void> saveString(String key, String value);

  ///retrieve string from storage
  String? retrieveString(String key);

  ///save boolean to storage
  Future<void> saveBool(String key, bool value);

  ///retrieve boolean from storage
  bool? retrieveBool(String key);
}

@LazySingleton(as: AppCache)
class AppCacheImpl implements AppCache {
  AppCacheImpl(this.pref);

  final SharedPreferences pref;

  @override
  bool isExpired(String key) {
    String? value = retrieveString(expiryDate(key));
    if (value != null) {
      var currentDate = DateTime.now();
      return currentDate.isAfter(DateTime.parse(value));
    } else {
      return true;
    }
  }

  @override
  Future<void> saveString(String key, String value) async {
    await pref.setString(key, value);
  }

  String? retrieveString(String key) {
    return pref.getString(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  @override
  bool? retrieveBool(String key) {
    return pref.getBool(key);
  }
}
