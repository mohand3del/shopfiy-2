import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  final AuthRepository _repository;

  const RequestPasswordResetUseCase(this._repository);

  Future<Either<Failure, Unit>> call({required String email}) {
    return _repository.requestPasswordReset(email: email);
  }
}
