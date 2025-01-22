import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? courseId;
  final String courseName;

  const CourseApiModel({
    this.courseId,
    required this.courseName,
  });

  const CourseApiModel.empty()
      : courseId = '',
        courseName = '';

// from json
  factory CourseApiModel.fromJson(Map<String, dynamic> json) {
    return CourseApiModel(
      courseId: json['_id'],
      courseName: json['courseName'],
    );
  }

// to json
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
    };
  }

// convert Api object to entity
//   factory CourseApiModel.fromEntity(CourseEntity entity) {
//     return CourseApiModel(
//       courseId: entity.courseId ?? '',
//       courseName: entity.courseName,
//     );
//   }

  static CourseApiModel fromEntity(CourseEntity entity) => CourseApiModel(
        courseName: entity.courseName,
      );

// convert entity to api object
  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      courseName: courseName,
    );
  }

// convert api list to entity list
  List<CourseEntity> toEntityList(List<CourseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [courseId, courseName];
}
