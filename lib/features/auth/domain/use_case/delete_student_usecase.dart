import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/repository/student_repository.dart';

class DeleteStudentParams extends Equatable {
  final String studentId;

  const DeleteStudentParams({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}

class DeleteStudentUsecase
    implements UsecaseWithParams<void, DeleteStudentParams> {
  final IAuthRepository repository;

  DeleteStudentUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteStudentParams params) async {
    return await repository.deleteStudent(params.studentId);
  }
}
