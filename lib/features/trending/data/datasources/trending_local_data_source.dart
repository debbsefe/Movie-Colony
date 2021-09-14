import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/models/tv_list/tv_list_model.dart';
import '../../../../core/utils/strings.dart';

abstract class TrendingLocalDataSource {
  ///method to fetch the last data that was fetched,
  ///throws an exception if no cache data is present
  Future<List<TvListModel>> getCachedTrendingDaily();

  Future<List<TvListModel>> getCachedTrendingWeekly();

  //method to cache the last data that was fetched
  Future<void> cacheLastTrendingDaily(List<TvListModel> trendingModel);

  Future<void> cacheLastTrendingWeekly(List<TvListModel> trendingModel);
}

@LazySingleton(as: TrendingLocalDataSource)
class TrendingLocalDataSourceImpl implements TrendingLocalDataSource {
  TrendingLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<TvListModel>> getCachedTrendingWeekly() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<TvListModel>((json) => TvListModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<TvListModel>> getCachedTrendingDaily() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<TvListModel>((json) => TvListModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastTrendingWeekly(List<TvListModel> trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(List<dynamic>.from(trendingModel.map((x) => x.toJson()))),
    );
  }

  @override
  Future<void> cacheLastTrendingDaily(List<TvListModel> trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(List<dynamic>.from(trendingModel.map((x) => x.toJson()))),
    );
  }
}
