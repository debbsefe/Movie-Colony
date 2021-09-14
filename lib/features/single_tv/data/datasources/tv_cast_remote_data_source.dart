import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';
import '../models/tv_cast_model.dart';

abstract class TvCastRemoteDataSource {
  Future<List<TvCastModel>> getRemoteTvCast(String id);
}

@LazySingleton(as: TvCastRemoteDataSource)
class TvCastRemoteDataSourceImpl implements TvCastRemoteDataSource {
  TvCastRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<List<TvCastModel>> getRemoteTvCast(String id) async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'tv/$id/credits?api_key=$_token'.baseurl;
    final response = await client.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['cast']
          .map<TvCastModel>((json) => TvCastModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
