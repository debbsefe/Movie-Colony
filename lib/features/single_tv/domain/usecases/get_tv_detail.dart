import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_detail_repository.dart';

@LazySingleton()
class GetTvDetail extends UseCase<TvDetail, Params> {
  GetTvDetail(this.repository);

  final TvDetailRepository repository;

  @override
  Future<Either<Failure, TvDetail>> call(Params params) async {
    return await repository.getTvDetail(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
