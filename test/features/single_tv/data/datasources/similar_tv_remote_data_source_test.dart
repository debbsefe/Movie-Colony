import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list_model.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/single_tv/constants.dart';

class MockClient extends Mock implements http.Client {}

class MockConfig extends Mock implements Config {}

void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late SimilarTvRemoteDataSourceImpl dataSource;
  var url = Uri.parse('tv/$tId/similar?api_key=123456'.baseurl);
  setUp(() {
    client = MockClient();
    mockConfig = MockConfig();
    dataSource =
        SimilarTvRemoteDataSourceImpl(client: client, config: mockConfig);
  });
  void stubFetchToken() {
    //stub/mock answer when fetch token method is called
    when(mockConfig.fetchToken(Strings.apiKeyTmdb))
        .thenAnswer((_) async => '123456');
  }

  group('fetchSimilarTv', () {
    test('returns SimilarTv if the http call completes successfully', () async {
      stubFetchToken();
      when(client.get(url)).thenAnswer(
          (_) async => http.Response(dataReader('tv_list/tv_list.json'), 200));

      expect(
          await dataSource.getRemoteSimilarTv(tId), isA<List<TvListModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteSimilarTv(tId),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
