abstract class Either<F, S> {
  const Either();

  T fold<T>(T Function(F failure) failureFn, T Function(S success) successFn);

  bool get isFailure => this is Failure<F, S>;
  bool get isSuccess => this is Success<F, S>;

  Failure<F, S>? get asFailure => this is Failure<F, S> ? this as Failure<F, S> : null;
  Success<F, S>? get asSuccess => this is Success<F, S> ? this as Success<F, S> : null;
}

class Failure<F, S> extends Either<F, S> {
  final F value;

  const Failure(this.value);

  @override
  T fold<T>(T Function(F failure) failureFn, T Function(S success) successFn) => failureFn(value);
}

class Success<F, S> extends Either<F, S> {
  final S value;

  const Success(this.value);

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
