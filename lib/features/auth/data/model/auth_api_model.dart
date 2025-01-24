import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/student_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_api_model.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_api_model.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final BatchApiModel batch;
  final List<CourseApiModel> courses;
  final String username;
  final String password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  // auto generates the json values (From Json)
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // to entity
  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      fname: fname,
      lname: lname,
      image: image,
      batch: batch.toEntity(),
      courses: courses.map((e) => e.toEntity()).toList(),
      username: username,
      password: password,
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(StudentEntity entity) {
    return AuthApiModel(
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      batch: BatchApiModel.fromEntity(entity.batch),
      courses: entity.courses.map((e) => CourseApiModel.fromEntity(e)).toList(),
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [
        fname,
        lname,
        image,
        batch,
        courses,
        username,
        password,
      ];
}
