import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';

// import '../../../../data/data_reader.dart';
import 'categories_remote_data_source_test.mocks.dart';

@GenerateMocks([
  http.Client,
  Config
], customMocks: [
  MockSpec<Config>(as: #MockConfig2, returnNullOnMissingStub: true),
])
void main() {
  late MockClient client;
  late MockConfig mockConfig;
  late CategoriesRemoteDataSourceImpl dataSource;
  Uri url = Uri.parse(
      'https://api.themoviedb.org/3/genre/tv/list?api_key=123456&language=en-US');
  setUp(() {
    client = MockClient();
    mockConfig = MockConfig();
    dataSource =
        CategoriesRemoteDataSourceImpl(client: client, config: mockConfig);
  });
  void stubFetchToken() {
    //stub/mock answer when fetch token method is called
    when(mockConfig.fetchToken(Strings.apiKeyTmdb))
        .thenAnswer((_) async => '123456');
  }

  group('fetchCategory', () {
    // test('returns a List of category
    //if the http call completes successfully',
    //     () async {
    //   stubFetchToken();
    //   when(client.get(url)).thenAnswer((_) async =>
    //       http.Response(dataReader('categories/categories_list.json'), 200));

    //   expect(
    //       await dataSource.getRemoteCategories(),
    // isA<List<CategoriesModel>>());
    // });

    test('throws an exception if the http call completes with an error', () {
      stubFetchToken();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteCategories(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
