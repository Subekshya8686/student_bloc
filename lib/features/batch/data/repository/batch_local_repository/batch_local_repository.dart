import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class BatchLocalRepository implements IBatchRepository {
  final BatchLocalDataSource _batchLocalDataSource;
  BatchLocalRepository({required BatchLocalDataSource batchLocalDataSource})
      : _batchLocalDataSource = batchLocalDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batchEntity) {
    try {
      _batchLocalDataSource.createBatch(batchEntity);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      await _batchLocalDataSource.deleteBatch(id);
      return Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Error Deleting Batch: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      final batches = await _batchLocalDataSource.getAllBatches();
      return Right(batches);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Error Deleting Batch: $e'),
      );
    }
  }
}
