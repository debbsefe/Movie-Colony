import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/strings.dart';
import '../models/categories_model.dart';

abstract class CategoriesLocalDataSource {
  ///method to fetch the last category that was fetched,
  ///throws an exception if no cache data is present
  Future<List<CategoriesModel>> getCachedCategory();

  //method to cache the last category that was fetched
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel);
}

@LazySingleton(as: CategoriesLocalDataSource)
class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  CategoriesLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<CategoriesModel>> getCachedCategory() {
    final jsonString = sharedPreferences.getString(Strings.cachedCategory);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<CategoriesModel>((json) => CategoriesModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel) {
    sharedPreferences.setString(
        expiryDate(Strings.cachedCategory), sevenDaysLater);
    return sharedPreferences.setString(
      Strings.cachedCategory,
      json.encode(List<dynamic>.from(categoriesModel.map((x) => x.toJson()))),
    );
  }
}
