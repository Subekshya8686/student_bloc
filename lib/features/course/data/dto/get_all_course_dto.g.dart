// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCourseDTO _$GetAllCourseDTOFromJson(Map<String, dynamic> json) =>
    GetAllCourseDTO(
      count: (json['count'] as num).toInt(),
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCourseDTOToJson(GetAllCourseDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
