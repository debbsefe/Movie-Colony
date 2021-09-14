// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/categories.dart';
import '../repositories/categories_repository.dart';

@LazySingleton()
class GetAllCategories extends UseCase<List<Categories>, NoParams> {
  GetAllCategories(this.repository);

  final CategoriesRepository repository;

  @override
  Future<Either<Failure, List<Categories>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
