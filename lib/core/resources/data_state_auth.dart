abstract class DataStateAuth<T> {
  final T? data;
  final String? error;

  const DataStateAuth({this.data, this.error});
}

class DataAuthSuccess<T> extends DataStateAuth<T> {
  const DataAuthSuccess(T data) : super(data: data);
}

class DataAuthFailed<T> extends DataStateAuth<T> {
  const DataAuthFailed(String error) : super(error: error);
}

class DataWrongCode<T> extends DataStateAuth<T> {
  const DataWrongCode(String msg) : super(error: msg);
}