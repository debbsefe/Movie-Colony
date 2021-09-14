import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/trending/domain/repositories/trending_repository.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_weekly.dart';

import '../../../../data/tv_list/constants.dart';

class MockTrendingRepository extends Mock implements TrendingRepository {}

void main() {
  MockTrendingRepository mockTrendingRepository;
  GetWeeklyTrending usecase;

  test(
    'should get Trending from the repository',
    () async {
      mockTrendingRepository = MockTrendingRepository();
      usecase = GetWeeklyTrending(mockTrendingRepository);
      // arrange, stub the method
      when(mockTrendingRepository.getTrendingWeekly())
          .thenAnswer((_) async => const Right(tTvListModel));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tTvListModel));
      verify(mockTrendingRepository.getTrendingWeekly());
      verifyNoMoreInteractions(mockTrendingRepository);
    },
  );
}
