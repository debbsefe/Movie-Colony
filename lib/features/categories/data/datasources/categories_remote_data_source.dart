import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';
import '../models/categories_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoriesModel>> getRemoteCategories();
}

@LazySingleton(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  CategoriesRemoteDataSourceImpl({required this.client, required this.config});

  final http.Client client;
  final Config config;

  @override
  Future<List<CategoriesModel>> getRemoteCategories() async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'genre/tv/list?api_key=$_token&language=en-US'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed['genres']
          .map<CategoriesModel>((json) => CategoriesModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
