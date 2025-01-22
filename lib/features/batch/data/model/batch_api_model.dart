import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    this.batchId,
    required this.batchName,
  });

  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';

// from json
  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

// to json
  Map<String, dynamic> toJson() {
    return {
      'batchName': batchName,
    };
  }

// convert Api object to entity
//   factory BatchApiModel.fromEntity(BatchEntity entity) {
//     return BatchApiModel(
//       batchName: entity.batchName,
//     );
//   }

  static BatchApiModel fromEntity(BatchEntity entity) => BatchApiModel(
        batchName: entity.batchName,
      );

// convert entity to api object
  BatchEntity toEntity() {
    return BatchEntity(
      batchId: batchId,
      batchName: batchName,
    );
  }

// convert api list to entity list
  static List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [batchId, batchName];
}
