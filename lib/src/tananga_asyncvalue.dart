abstract class TanangaAsyncValue<T> {
  const TanangaAsyncValue();

  /// Represents a loading state.
  const factory TanangaAsyncValue.loading() = _TanangaAsyncLoading<T>;

  /// Represents a data state with a value.
  const factory TanangaAsyncValue.data(T value) = _TanangaAsyncData<T>;

  /// Represents an error state with an exception and optional stack trace.
  const factory TanangaAsyncValue.error(Object error, [StackTrace? stackTrace]) = _TanangaAsyncError<T>;

  /// Checks if the current state is loading.
  bool get isLoading => this is _TanangaAsyncLoading<T>;

  /// Checks if the current state contains data.
  bool get hasData => this is _TanangaAsyncData<T>;

  /// Checks if the current state contains an error.
  bool get hasError => this is _TanangaAsyncError<T>;

  /// Returns the data if available, otherwise throws an exception.
  T get requireData => (this as _TanangaAsyncData<T>).value;

  /// Returns the error if available, otherwise null.
  Object? get error => this is _TanangaAsyncError<T> ? (this as _TanangaAsyncError<T>).error : null;

  /// Returns the stack trace if available, otherwise null.
  StackTrace? get stackTrace =>
      this is _TanangaAsyncError<T> ? (this as _TanangaAsyncError<T>).stackTrace : null;

  /// Maps the current state to a new value.
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error, StackTrace? stackTrace) error,
  }) {
    if (this is _TanangaAsyncLoading<T>) return loading();
    if (this is _TanangaAsyncData<T>) return data((this as _TanangaAsyncData<T>).value);
    if (this is _TanangaAsyncError<T>) {
      final e = this as _TanangaAsyncError<T>;
      return error(e.error, e.stackTrace);
    }
    throw StateError('Unhandled TanangaAsyncValue state: $this');
  }
}

class _TanangaAsyncLoading<T> extends TanangaAsyncValue<T> {
  const _TanangaAsyncLoading();
}

class _TanangaAsyncData<T> extends TanangaAsyncValue<T> {
  final T value;
  const _TanangaAsyncData(this.value);
}

class _TanangaAsyncError<T> extends TanangaAsyncValue<T> {
  final Object error;
  final StackTrace? stackTrace;
  const _TanangaAsyncError(this.error, [this.stackTrace]);
}

// void main() {
//   TanangaAsyncValue<int> value = const TanangaAsyncValue.loading();
//
//   print(value.isLoading); // true
//
//   value = const TanangaAsyncValue.data(42);
//   print(value.hasData); // true
//   print(value.requireData); // 42
//
//   value = const TanangaAsyncValue.error(Exception('Something went wrong'));
//   print(value.hasError); // true
//   print(value.error); // Exception: Something went wrong
//
//   final result = value.when(
//     loading: () => 'Loading...',
//     data: (data) => 'Data: $data',
//     error: (err, stack) => 'Error: $err',
//   );
//   print(result); // Error: Exception: Something went wrong
// }