abstract class TanangaEither<F, S> {
  const TanangaEither();

  T fold<T>(T Function(F failure) failureFn, T Function(S success) successFn);

  bool get isFailure => this is TanangaFailure<F, S>;
  bool get isSuccess => this is TanangaSuccess<F, S>;

  TanangaFailure<F, S>? get asFailure => this is TanangaFailure<F, S> ? this as TanangaFailure<F, S> : null;
  TanangaSuccess<F, S>? get asSuccess => this is TanangaSuccess<F, S> ? this as TanangaSuccess<F, S> : null;
}

class TanangaFailure<F, S> extends TanangaEither<F, S> {
  final F value;

  const TanangaFailure(this.value);

  @override
  T fold<T>(T Function(F failure) failureFn, T Function(S success) successFn) => failureFn(value);
}

class TanangaSuccess<F, S> extends TanangaEither<F, S> {
  final S value;

  const TanangaSuccess(this.value);

  @override
  T fold<T>(T Function(F failure) failureFn, T Function(S success) successFn) => successFn(value);
}

// void main() {
//   // A successful result
//   Either<String, int> result = Success(42);
//
//   if (result.isSuccess) {
//     print('Success: ${result.asSuccess?.value}');
//   } else if (result.isFailure) {
//     print('Failure: ${result.asFailure?.value}');
//   }
//
//   // Handling with fold
//   result.fold(
//     (failure) => print('Failure: $failure'), // Handles the Failure case
//     (success) => print('Success: $success'), // Handles the Success case
//   );
//
//   // A failure result
//   Either<String, int> error = Failure("Something went wrong");
//
//   error.fold(
//     (failure) => print('Failure: $failure'),
//     (success) => print('Success: $success'),
//   );
// }
