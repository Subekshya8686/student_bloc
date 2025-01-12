import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CourseLocalDatasource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createCourde(CourseEntity courseEntity) async {
    try {
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String d) async {
    try {
      await _hiveService.deleteCourse(d);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getAllCourses() {
    try {
      return _hiveService.getAllCourses().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
