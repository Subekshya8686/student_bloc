import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<void> createCourde(CourseEntity courseEntity);
  Future<List<CourseEntity>> getAllCourses();
  Future<void> deleteCourse(String d);
}
