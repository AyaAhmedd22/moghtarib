abstract class Failure {
  String get message;
}

class ServerFailure implements Failure {
  final String _message;

  ServerFailure(this._message);

  @override
  String get message => _message;
}

class NetworkFailure implements Failure {
  final String _message;

  NetworkFailure(this._message);

  @override
  String get message => _message;
}

