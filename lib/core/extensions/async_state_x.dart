import '../cubit/async_state.dart';

extension AsyncStateX<T> on AsyncState<T> {
  bool get isInitial => this is AsyncInitial<T>;
  bool get isLoading => this is AsyncLoading<T>;
  bool get isSuccess => this is AsyncSuccess<T>;
  bool get isError => this is AsyncFailure<T>;

  T? get dataOrNull => switch (this) {
        AsyncSuccess<T>(:final data) => data,
        _ => null,
      };

  String? get errorMessage => switch (this) {
        AsyncFailure<T>(:final failure) => failure?.toString(),
        _ => null,
      };

  dynamic get errorObject => switch (this) {
        AsyncFailure<T>(:final failure) => failure,
        _ => null,
      };
}
