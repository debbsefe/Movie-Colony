import 'package:injectable/injectable.dart';

import '../../../../core/notifiers/generic_state.dart';
import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/configuration.dart';
import '../../domain/usecases/get_configuration.dart';

@LazySingleton()
class ConfigurationNotifier extends GenericStateNotifier<Configuration> {
  ConfigurationNotifier(this.allConfiguration);

  final GetAllConfiguration allConfiguration;

  void fetchConfiguration() {
    sendRequest(() async {
      return await allConfiguration(NoParams());
    });
  }

  GenericState<Configuration> currentState() {
    return state;
  }

  String fetchPosterSizeUrl() {
    var current = currentState();
    if (current is Loaded<Configuration>) {
      return '${current.value?.secureBaseUrl}${current.value?.posterSizes[4]}/';
    } else {
      return 'https://image.tmdb.org/t/p/w500/';
    }
  }

  String fetchProfileSizeUrl() {
    var current = currentState();
    if (current is Loaded<Configuration>) {
      return '${current.value?.secureBaseUrl}${current.value?.profileSizes[3]}/';
    } else {
      return 'https://image.tmdb.org/t/p/original/';
    }
  }
}
