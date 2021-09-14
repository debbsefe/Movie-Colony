import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/similar_tv_repository.dart';

@LazySingleton()
class GetSimilarTv extends UseCase<List<TvList>, Params> {
  GetSimilarTv(this.repository);

  final SimilarTvRepository repository;

  @override
  Future<Either<Failure, List<TvList>>> call(Params params) async {
    return await repository.getSimilarTv(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
