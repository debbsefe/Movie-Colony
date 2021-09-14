import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/add_notif_list_repository.dart';
import '../datasources/add_notif_list_remote_data_source.dart';
import '../models/notification_list_model.dart';

@LazySingleton(as: AddNotifListRepository)
class AddNotifListRepositoryImpl implements AddNotifListRepository {
  AddNotifListRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AddNotifListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> addNotificationList(
      NotificationListModel model) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.addNotifListRemote(model);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(CacheFailure());
    }
  }
}
