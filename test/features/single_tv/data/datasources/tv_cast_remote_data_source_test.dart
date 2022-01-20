import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_cast_model.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/single_tv/constants.dart';

class MockClient extends Mock implements http.Client {}

class MockConfig extends Mock implements Config {}

void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late TvCastRemoteDataSourceImpl dataSource;
  var url = Uri.parse('tv/$tId/credits?api_key=123456'.baseurl);
  setUp(() {
    client = MockClient();
    mockConfig = MockConfig();
    dataSource = TvCastRemoteDataSourceImpl(client: client, config: mockConfig);
  });
  void stubFetchToken() {
    //stub/mock answer when fetch token method is called
    when(mockConfig.fetchToken(Strings.apiKeyTmdb))
        .thenAnswer((_) async => '123456');
  }

  group('fetchTvCast', () {
    test('returns TvCast if the http call completes successfully', () async {
      stubFetchToken();
      when(client.get(url)).thenAnswer((_) async =>
          http.Response(dataReader('single_tv/tv_cast_list.json'), 200));

      expect(await dataSource.getRemoteTvCast(tId), isA<List<TvCastModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteTvCast(tId),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
