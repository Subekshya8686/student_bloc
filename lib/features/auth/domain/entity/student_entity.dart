import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  // final String phone;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String username;
  final String password;

  const StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    // required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, fname, lname, image, batch, courses, username, password];
}
