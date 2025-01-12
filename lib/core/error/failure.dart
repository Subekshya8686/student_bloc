class Failure {
  final String message;
  final int? statusCode;

  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

// abstract class Failure extends Equatable {
//   final String message;
//
//   const Failure({
//     required this.message,
//   });
//
//   @override
//   List<Object> get props => [message];
// }

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

class ApiFailure extends Failure {
  final int statusCode;

  ApiFailure({
    required this.statusCode,
    required super.message,
  });
}
