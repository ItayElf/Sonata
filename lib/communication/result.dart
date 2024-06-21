class Result<T> {
  const Result({
    this.data,
    this.error,
  });

  final T? data;
  final String? error;

  bool get isError => error == null;
  bool get isOk => !isError;

  Result<T> copyWith({
    T? data,
    String? error,
  }) {
    return Result<T>(
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'Result(data: $data, error: $error)';

  @override
  bool operator ==(covariant Result<T> other) {
    if (identical(this, other)) return true;

    return other.data == data && other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode;
}
