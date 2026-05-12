import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../errors/failure.dart';
import '../extensions/async_state_x.dart';
import 'async_state.dart';

abstract class AsyncCubit<T> extends Cubit<AsyncState<T>> {
  AsyncCubit() : super(const AsyncState.initial());

  Future<void> execute(Future<T> Function() operation) async {
    emit(const AsyncState.loading());

    final result = await operation();
    emit(AsyncState.success(result));
  }

  Future<void> executeEither(
    Future<Either<Failure, T>> Function() operation,
  ) async {
    emit(const AsyncState.loading());

    final result = await operation();
    result.fold(
      (failure) => emit(AsyncState.failure(failure: failure)),
      (data) => emit(AsyncState.success(data)),
    );
  }

  void reset() => emit(const AsyncState.initial());

  T? get currentData => state.dataOrNull;

  bool get isLoading => state.isLoading;

  bool get hasError => state.isError;

  String? get failureMessage {
    final failure = switch (state) {
      AsyncFailure<T>(:final failure) => failure,
      _ => null,
    };
    return failure is Failure ? failure.message : failure?.toString();
  }
}
