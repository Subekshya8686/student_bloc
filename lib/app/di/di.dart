import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:softwarica_student_management_bloc/core/network/api_service.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/repository/student_local_repository/student_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/create_student_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/login_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/remote_datasource/batch_remote_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_local_repository/batch_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_remote_repository/batch_remote_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/local_datasource/course_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_remote_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/bloc/course_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view_model/home_cubit.dart';
import 'package:softwarica_student_management_bloc/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initBatchDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initCourseDependencies();
}

_initApiService() {
  // remotee data source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initBatchDependencies() async {
  //local data source
  getIt.registerLazySingleton<BatchLocalDataSource>(
      () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  // remote data source
  getIt.registerLazySingleton<BatchRemoteDatasource>(
    () => BatchRemoteDatasource(
      dio: getIt<Dio>(),
    ),
  );

//local repository
  getIt.registerLazySingleton<BatchLocalRepository>(
      () => BatchLocalRepository(batchLocalDataSource: getIt()));

//  remote repo
  getIt.registerLazySingleton(
    () => BatchRemoteRepository(
      getIt<BatchRemoteDatasource>(),
    ),
  );

// usecases
//   getIt.registerLazySingleton<CreateBatchUsecase>(
//       () => CreateBatchUsecase(getIt<BatchLocalRepository>()));

  getIt.registerLazySingleton<CreateBatchUsecase>(
      () => CreateBatchUsecase(getIt<BatchRemoteRepository>()));

  // getIt.registerLazySingleton<GetAllBatchUsecase>(() => GetAllBatchUsecase(
  //       repository: getIt<BatchLocalRepository>(),
  //     ));
  getIt.registerLazySingleton<GetAllBatchUsecase>(() => GetAllBatchUsecase(
        repository: getIt<BatchRemoteRepository>(),
      ));

  // getIt.registerLazySingleton<DeleteBatchUsecase>(() => DeleteBatchUsecase(
  //       repository: getIt<BatchLocalRepository>(),
  //     ));
  getIt.registerLazySingleton<DeleteBatchUsecase>(() => DeleteBatchUsecase(
        repository: getIt<BatchRemoteRepository>(),
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
  getIt.registerLazySingleton<CourseRemoteDatasource>(
      () => CourseRemoteDatasource(dio: getIt<Dio>()));

// repository
  getIt.registerLazySingleton<CourseLocalRepository>(
      () => CourseLocalRepository(courseLocalDatasource: getIt()));

  //  remote repo
  getIt.registerLazySingleton(
    () => CourseRemoteRepository(
      getIt<CourseRemoteDatasource>(),
    ),
  );

// usecases
//   getIt.registerLazySingleton<CreateCourseUsecase>(() =>
//       CreateCourseUsecase(courseRepository: getIt<CourseLocalRepository>()));
  getIt.registerLazySingleton<CreateCourseUsecase>(() =>
      CreateCourseUsecase(courseRepository: getIt<CourseRemoteRepository>()));

  // getIt.registerLazySingleton<GetAllCourseUsecase>(() => GetAllCourseUsecase(
  //       repository: getIt<CourseLocalRepository>(),
  //     ));
  getIt.registerLazySingleton<GetAllCourseUsecase>(() => GetAllCourseUsecase(
        repository: getIt<CourseRemoteRepository>(),
      ));

  // getIt.registerLazySingleton<DeleteCourseUsecase>(() => DeleteCourseUsecase(
  //       repository: getIt<CourseLocalRepository>(),
  //     ));
  getIt.registerLazySingleton<DeleteCourseUsecase>(() => DeleteCourseUsecase(
        repository: getIt<CourseRemoteRepository>(),
      ));

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
  // data source
  getIt.registerLazySingleton<StudentLocalDatasource>(
      () => StudentLocalDatasource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<StudentLocalRepository>(() =>
      StudentLocalRepository(
          studentLocalDataSource: getIt<StudentLocalDatasource>()));

// Use Cases
  getIt.registerLazySingleton<CreateStudentUsecase>(
      () => CreateStudentUsecase(getIt<StudentLocalRepository>()));
  // getIt.registerLazySingleton<GetAllStudentsUsecase>(
  //     () => GetAllStudentsUsecase(getIt<StudentLocalRepository>()));
  //
  // getIt.registerLazySingleton<DeleteStudentUsecase>(
  //     () => DeleteStudentUsecase(getIt<StudentLocalRepository>()));

  // RegisterBloc with student-related dependencies
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
      createStudentUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<StudentLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
