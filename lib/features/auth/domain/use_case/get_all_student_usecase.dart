import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/student_entity.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/repository/student_repository.dart';

class GetAllStudentsUsecase
    implements UsecaseWithoutParams<List<StudentEntity>> {
  final IAuthRepository repository;

  GetAllStudentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<StudentEntity>>> call() async {
    try {
      return await repository.getAllStudents();
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
