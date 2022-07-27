import '../error/failure.dart';

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DataBaseFailure:
        return 'DataBase Failure';
      case EmptyDataBaseFailure:
        return 'Empty DataBase Failure';
      case InsertDataBaseFailure:
        return 'Insert DataBase Failure';
      case UpdateDataBaseFailure:
        return 'Update DataBase Failure';
      case DeleteDataBaseFailure:
        return 'Delete DataBase Failure';
      default:
        return 'Unexpected Error';
    }
  }