import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/configuration/constants.dart';
import '../../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late ConfigurationLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = ConfigurationLocalDataSourceImpl(mockPref);
  });

  group('GetCachedCategory', () {
    test('Return List<ConfigurationModel> when cache is available', () async {
      when(mockPref.getString(Strings.cachedConfiguration))
          .thenReturn(dataReader('configuration/configuration.json'));

      expect(
          await dataSource.getCachedConfiguration(), isA<ConfigurationModel>());
    });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedConfiguration)).thenReturn(null);

      expect(() => dataSource.getCachedConfiguration(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheLastConfiguration', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheLastConfiguration(tConfigurationModel);
        // assert
        final expectedJsonString = json.encode(tConfigurationModel.toJson());
        verify(mockPref.setString(
          Strings.cachedConfiguration,
          expectedJsonString,
        ));
      },
    );
  });
}
