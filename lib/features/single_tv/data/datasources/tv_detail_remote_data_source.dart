import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';
import '../models/tv_detail_model.dart';

abstract class TvDetailRemoteDataSource {
  Future<TvDetailModel> getRemoteTvDetail(String id);
}

@LazySingleton(as: TvDetailRemoteDataSource)
class TvDetailRemoteDataSourceImpl implements TvDetailRemoteDataSource {
  TvDetailRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<TvDetailModel> getRemoteTvDetail(String id) async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'tv/$id?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException();
    }
  }
}
