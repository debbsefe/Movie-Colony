import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late CategoriesLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = CategoriesLocalDataSourceImpl(mockPref);
  });
  final tCategoriesModel = [
    CategoriesModel(id: 1, name: 'Romance'),
    CategoriesModel(id: 2, name: 'Comedy'),
    CategoriesModel(id: 3, name: 'Drama'),
  ];
  group('GetCachedCategory', () {
    test('Return List<CategoriesModel> when cache is available', () async {
      when(mockPref.getString(Strings.cachedCategory))
          .thenReturn(dataReader('categories/categories_list.json'));

      expect(
          await dataSource.getCachedCategory(), isA<List<CategoriesModel>>());
    });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedCategory)).thenReturn(null);

      expect(() => dataSource.getCachedCategory(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheLastCategory', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheLastCategory(tCategoriesModel);
        // assert
        final expectedJsonString = json.encode(
            List<dynamic>.from(tCategoriesModel.map((x) => x.toJson())));
        verify(mockPref.setString(
          Strings.cachedCategory,
          expectedJsonString,
        ));
      },
    );
  });
}
