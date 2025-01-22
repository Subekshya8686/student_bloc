import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/remote_datasource/batch_remote_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class BatchRemoteRepository implements IBatchRepository {
  final BatchRemoteDatasource _batchRemoteDatasource;

  BatchRemoteRepository(this._batchRemoteDatasource);
  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batchEntity) async {
    try {
      _batchRemoteDatasource.createBatch(batchEntity);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    // TODO: implement getAllBatches
    throw UnimplementedError();
  }
}
