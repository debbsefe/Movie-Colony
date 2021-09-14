// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/repositories/categories_repository.dart';
import 'package:movie_colony/features/categories/domain/usecases/get_categories.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

void main() {
  MockCategoriesRepository mockCategoriesRepository;
  GetAllCategories usecase;
  final tCategories = [
    const Categories(id: 1, name: 'Romance'),
    const Categories(id: 2, name: 'Comedy'),
    const Categories(id: 3, name: 'Drama'),
  ];

  test(
    'should get categories from the repository',
    () async {
      mockCategoriesRepository = MockCategoriesRepository();
      usecase = GetAllCategories(mockCategoriesRepository);
      // arrange, stub the method
      when(mockCategoriesRepository.getCategories())
          .thenAnswer((_) async => Right(tCategories));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tCategories));
      verify(mockCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    },
  );
}
