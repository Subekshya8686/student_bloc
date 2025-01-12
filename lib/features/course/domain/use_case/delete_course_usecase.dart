import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/repository/course_repository.dart';

class DeleteCourseParams {
  final int courseId;

  DeleteCourseParams({required this.courseId});
}

class DeleteCourseUsecase
    implements UsecaseWithParams<void, DeleteCourseParams> {
  // check internet
  final ICourseRepository repository;

  DeleteCourseUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) {
    return repository.deleteCourse(params.courseId);
  }
}
