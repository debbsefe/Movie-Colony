import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';
import 'package:movie_colony/features/configuration/domain/repositories/configuration_repository.dart';
import 'package:movie_colony/features/configuration/domain/usecases/get_configuration.dart';

class MockConfigurationRepository extends Mock
    implements ConfigurationRepository {}

void main() {
  MockConfigurationRepository mockConfigurationRepository;
  GetAllConfiguration usecase;
  const tConfiguration = Configuration(
    baseUrl: 'http://',
    secureBaseUrl: 'https://',
    backdropSizes: ['w500'],
    logoSizes: ['w500'],
    posterSizes: ['w500'],
    profileSizes: ['w500'],
    stillSizes: ['w500'],
    changeKeys: ['w500'],
  );

  test(
    'should get Configuration from the repository',
    () async {
      mockConfigurationRepository = MockConfigurationRepository();
      usecase = GetAllConfiguration(mockConfigurationRepository);
      // arrange, stub the method
      when(mockConfigurationRepository.getConfiguration())
          .thenAnswer((_) async => const Right(tConfiguration));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tConfiguration));
      verify(mockConfigurationRepository.getConfiguration());
      verifyNoMoreInteractions(mockConfigurationRepository);
    },
  );
}
