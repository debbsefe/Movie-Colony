import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';
import '../models/configuration_model.dart';

abstract class ConfigurationRemoteDataSource {
  Future<ConfigurationModel> getRemoteConfiguration();
}

@LazySingleton(as: ConfigurationRemoteDataSource)
class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  ConfigurationRemoteDataSourceImpl(
      {required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<ConfigurationModel> getRemoteConfiguration() async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'configuration/?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      return ConfigurationModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException();
    }
  }
}
