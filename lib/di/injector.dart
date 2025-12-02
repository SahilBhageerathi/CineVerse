import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:inshorts_task/Core/Contants/global.dart';
import 'package:inshorts_task/data/api_client.dart';
import 'package:inshorts_task/data/local/movie_entity.dart';
import 'package:inshorts_task/data/network/movie_api.dart';
import 'package:inshorts_task/data/repository/movie_repository.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(() => DioApiClient().dio);

  sl.registerLazySingleton<MovieApi>(() => MovieApi(sl<Dio>()));

  sl.registerLazySingleton<Box<MovieEntity>>(
        () => Hive.box<MovieEntity>(GlobalConstant.moviesBox),
  );

  sl.registerLazySingleton<Box<List<int>>>(
        () => Hive.box<List<int>>(GlobalConstant.popularIdsBox),
         instanceName: GlobalConstant.popularIdsInstanceNme,
  );

  sl.registerLazySingleton<Box<List<int>>>(
        () => Hive.box<List<int>>(GlobalConstant.nowPlayingIdsBox),
    instanceName: GlobalConstant.nowPlayingInstanceName,
  );

  sl.registerLazySingleton<MovieRepository>(
        () => MovieRepository(
      sl<MovieApi>(),
      sl<Box<MovieEntity>>(),
      sl<Box<List<int>>>(instanceName: GlobalConstant.popularIdsInstanceNme),
      sl<Box<List<int>>>(instanceName: GlobalConstant.nowPlayingInstanceName),
    ),
  );
}

