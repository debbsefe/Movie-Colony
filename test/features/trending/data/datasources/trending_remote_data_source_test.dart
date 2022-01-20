import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list_model.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

import '../../../../data/data_reader.dart';

class MockConfig extends Mock implements Config {}

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late TrendingRemoteDataSourceImpl dataSource;
  Uri url = Uri.parse('trending/tv/week?api_key=123456'.baseurl);
  setUp(() {
    client = MockClient();
    mockConfig = MockConfig();
    dataSource =
        TrendingRemoteDataSourceImpl(client: client, config: mockConfig);
  });
  void stubFetchToken() {
    //stub/mock answer when fetch token method is called
    when(mockConfig.fetchToken(Strings.apiKeyTmdb))
        .thenAnswer((_) async => '123456');
  }

  group('fetchTrending', () {
    test('returns a List of trending if the http call completes successfully',
        () async {
      stubFetchToken();
      when(client.get(url)).thenAnswer(
          (_) async => http.Response(dataReader('tv_list/tv_list.json'), 200));

      expect(
          await dataSource.getRemoteTrendingWeekly(), isA<List<TvListModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteTrendingWeekly(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
