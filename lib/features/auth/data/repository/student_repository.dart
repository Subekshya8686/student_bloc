import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/student_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> addStudent(StudentEntity studentEntity);
  Future<Either<Failure, List<StudentEntity>>> getAllStudents();
  Future<Either<Failure, void>> deleteStudent(int d);
}
