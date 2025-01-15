import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/student_entity.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/repository/student_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CreateStudentParams extends Equatable {
  final String fname;
  final String lname;
  final String username;
  final String password;
  final BatchEntity batch;
  final List<CourseEntity> courses;

  const CreateStudentParams({
    required this.fname,
    required this.lname,
    required this.username,
    required this.password,
    required this.batch,
    required this.courses,
  });

  @override
  List<Object?> get props => [fname, lname, username, password, batch, courses];
}

class CreateStudentUsecase
    implements UsecaseWithParams<void, CreateStudentParams> {
  final IAuthRepository repository;

  CreateStudentUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateStudentParams params) async {
    try {
      // Create a StudentEntity object from the params
      final student = StudentEntity(
        fname: params.fname,
        lname: params.lname,
        username: params.username,
        password: params.password,
        batch: params.batch,
        courses: params.courses,
      );

      // Call the repository to create the student
      return await repository.addStudent(student);
    } catch (error) {
      // Handle exceptions and return a Failure
      return Left(Failure(message: error.toString()));
    }
  }
}
