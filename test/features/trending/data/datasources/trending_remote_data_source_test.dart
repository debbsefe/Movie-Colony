import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';
import 'package:movie_colony/features/trending/data/models/trending_model.dart';

import '../../../../data/data_reader.dart';

class MockConfig extends Mock implements Config {}

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late TrendingRemoteDataSourceImpl dataSource;
  Uri url = Uri.parse('genre/tv/list?api_key=123456'.baseurl);
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

  group('fetchCategory', () {
    test('returns a List of category if the http call completes successfully',
        () async {
      stubFetchToken();
      when(client.get(url)).thenAnswer(
          (_) async => http.Response(dataReader('Trending_list.json'), 200));

      expect(await dataSource.getRemoteTrending(), isA<List<TrendingModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteTrending(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
