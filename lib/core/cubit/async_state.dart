sealed class AsyncState<T> {
  const AsyncState();

  const factory AsyncState.initial() = AsyncInitial<T>;
  const factory AsyncState.loading() = AsyncLoading<T>;
  const factory AsyncState.success(T data) = AsyncSuccess<T>;
  const factory AsyncState.failure({dynamic failure}) = AsyncFailure<T>;
}

final class AsyncInitial<T> extends AsyncState<T> {
  const AsyncInitial();
}

final class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();
}

final class AsyncSuccess<T> extends AsyncState<T> {
  const AsyncSuccess(this.data);

  final T data;
}

final class AsyncFailure<T> extends AsyncState<T> {
  const AsyncFailure({this.failure});

  final dynamic failure;
}
