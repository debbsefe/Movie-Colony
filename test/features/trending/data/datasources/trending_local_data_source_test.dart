import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
// import 'package:movie_colony/features/trending/data/models/trending_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/tv_list/constants.dart';

// import '../../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late TrendingLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = TrendingLocalDataSourceImpl(mockPref);
  });

  group('getCachedTrendingWeekly', () {
    // test('Return List<TrendingModel> when cache is available', () async {
    //   when(mockPref.getString(Strings.cachedTrending))
    //       .thenReturn(dataReader('trending/trending_list.json'));

    //   expect(await dataSource.getCachedTrendingWeekly(),
    //       isA<List<TrendingModel>>());
    // });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedTrending)).thenReturn(null);

      expect(() => dataSource.getCachedTrendingWeekly(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheLastTrendingWeekly', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheLastTrendingWeekly(tTvListModel);
        // assert
        final expectedJsonString = json
            .encode(List<dynamic>.from(tTvListModel.map((x) => x.toJson())));
        verify(mockPref.setString(
          Strings.cachedTrending,
          expectedJsonString,
        ));
      },
    );
  });
}
