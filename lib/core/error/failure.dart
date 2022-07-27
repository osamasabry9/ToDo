import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class DataBaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class EmptyDataBaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InsertDataBaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UpdateDataBaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class DeleteDataBaseFailure extends Failure {
  @override
  List<Object> get props => [];
}
