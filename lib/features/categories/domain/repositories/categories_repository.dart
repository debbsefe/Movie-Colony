// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/categories.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<Categories>>> getCategories();
}
