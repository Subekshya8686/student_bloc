import 'package:get_it/get_it.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_local_repository/batch_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/local_datasource/course_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/bloc/course_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view_model/home_cubit.dart';
import 'package:softwarica_student_management_bloc/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initBatchDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initCourseDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initBatchDependencies() async {
  // data source
  getIt.registerLazySingleton<BatchLocalDataSource>(
      () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<BatchLocalRepository>(
      () => BatchLocalRepository(batchLocalDataSource: getIt()));

// usecases
  getIt.registerLazySingleton<CreateBatchUsecase>(
      () => CreateBatchUsecase(getIt<BatchLocalRepository>()));

  getIt.registerLazySingleton<GetAllBatchUsecase>(() => GetAllBatchUsecase(
        repository: getIt<BatchLocalRepository>(),
      ));

  getIt.registerLazySingleton<DeleteBatchUsecase>(() => DeleteBatchUsecase(
        repository: getIt<BatchLocalRepository>(),
      ));

  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(
      createBatchUsecase: getIt<CreateBatchUsecase>(),
      getAllBatchUsecase: getIt<GetAllBatchUsecase>(),
      deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
    ),
  );
}

_initCourseDependencies() async {
  // data source
  getIt.registerLazySingleton<CourseLocalDatasource>(
      () => CourseLocalDatasource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<CourseLocalRepository>(
      () => CourseLocalRepository(courseLocalDatasource: getIt()));

// usecases
  getIt.registerLazySingleton<CreateCourseUsecase>(() =>
      CreateCourseUsecase(courseRepository: getIt<CourseLocalRepository>()));

  getIt.registerLazySingleton<GetAllCourseUsecase>(() => GetAllCourseUsecase(
        repository: getIt<CourseLocalRepository>(),
      ));

  getIt.registerLazySingleton<DeleteCourseUsecase>(() => DeleteCourseUsecase(
        repository: getIt<CourseLocalRepository>(),
      ));

  // getIt.registerFactory<BatchBloc>(
  //   () => BatchBloc(
  //     createBatchUsecase: getIt<CreateBatchUsecase>(),
  //     getAllBatchUsecase: getIt<GetAllBatchUsecase>(),
  //     deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
  //   ),
  // );

  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      createCourseUsecase: getIt<CreateCourseUsecase>(),
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
      deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
