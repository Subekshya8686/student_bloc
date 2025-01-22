import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_api_model.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CourseRemoteDatasource implements ICourseDataSource {
  final Dio _dio;

  CourseRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createCourse(CourseEntity courseEntity) async {
    try {
      // convert entity to model
      var courseApiModel = CourseApiModel.fromEntity(courseEntity);
      var response = await _dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String d) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<List<CourseEntity>> getAllCourses() {
    // TODO: implement getAllCourses
    throw UnimplementedError();
  }
}
