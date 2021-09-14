import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';

import '../../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

class MockConfig extends Mock implements Config {}

void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late ConfigurationRemoteDataSourceImpl dataSource;
  Uri url = Uri.parse('configuration/?api_key=123456'.baseurl);
  setUp(() {
    client = MockClient();
    mockConfig = MockConfig();
    dataSource =
        ConfigurationRemoteDataSourceImpl(client: client, config: mockConfig);
  });
  void stubFetchToken() {
    //stub/mock answer when fetch token method is called
    when(mockConfig.fetchToken(Strings.apiKeyTmdb))
        .thenAnswer((_) async => '123456');
  }

  group('fetchConfiguration', () {
    test('returns configuration if the http call completes successfully',
        () async {
      stubFetchToken();
      when(client.get(url)).thenAnswer((_) async =>
          http.Response(dataReader('configuration/configuration.json'), 200));

      expect(
          await dataSource.getRemoteConfiguration(), isA<ConfigurationModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteConfiguration(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
