import 'package:get_it/get_it.dart';

import 'data/datasources/add_notif_list_remote_data_source.dart';
import 'data/datasources/notif_list_remote_data_source.dart';
import 'data/repositories/add_notif_list_repository_impl.dart';
import 'data/repositories/notif_list_repository_impl.dart';
import 'domain/repositories/add_notif_list_repository.dart';
import 'domain/repositories/notif_list_repository.dart';
import 'domain/usecases/add_notif_list.dart';
import 'presentation/notifiers/add_notif_list_notifier.dart';

class NotificationListServiceLocator {
  NotificationListServiceLocator(this.sl);
  final GetIt sl;

// ignore_for_file: cascade_invocations
  void init() {
    ///view models/notifiers

    sl.registerLazySingleton<AddNotifListNotifier>(
      () => AddNotifListNotifier(sl()),
    );

    ///datasources
    sl.registerLazySingleton<AddNotifListRemoteDataSource>(
      () => AddNotifListRemoteDataSourceImpl(
        methods: sl(),
      ),
    );

    sl.registerLazySingleton<NotifListRemoteDataSource>(
      () => NotifListRemoteDataSourceImpl(
        methods: sl(),
      ),
    );

    ///usecases
    sl.registerLazySingleton(() => AddNotificationList(sl()));

    ///repository

    sl.registerLazySingleton<AddNotifListRepository>(
      () => AddNotifListRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<NotifListRepository>(
      () => NotifListRepositoryImpl(
        remoteDataSource: sl(),
      ),
    );
  }
}
