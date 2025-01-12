import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/course_entity.dart';

// dart run build_runner build -d
part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? courseId;
  @HiveField(1)
  final String courseName;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  const CourseHiveModel.initial()
      : courseId = "",
        courseName = '';

  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

  CourseEntity toEntity() {
    return CourseEntity(
      courseName: courseName,
      courseId: courseId,
    );
  }

  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entityList) {
    return entityList
        .map((entity) => CourseHiveModel.fromEntity(entity))
        .toList();
  }

  static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [courseId, courseName];
}
