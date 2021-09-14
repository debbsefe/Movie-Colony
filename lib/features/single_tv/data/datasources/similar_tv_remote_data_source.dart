import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/tv_list/tv_list_model.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';

abstract class SimilarTvRemoteDataSource {
  Future<List<TvListModel>> getRemoteSimilarTv(String id);
}

@LazySingleton(as: SimilarTvRemoteDataSource)
class SimilarTvRemoteDataSourceImpl implements SimilarTvRemoteDataSource {
  SimilarTvRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<List<TvListModel>> getRemoteSimilarTv(String id) async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'tv/$id/similar?api_key=$_token'.baseurl;
    final response = await client.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['results']
          .map<TvListModel>((json) => TvListModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
