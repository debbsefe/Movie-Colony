import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/trending_repository.dart';

@LazySingleton()
class GetWeeklyTrending extends UseCase<List<TvList>, NoParams> {
  GetWeeklyTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, List<TvList>>> call(NoParams params) async {
    return await repository.getTrendingWeekly();
  }
}
