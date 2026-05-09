import '../entities/user_entity.dart';
import '../../../../core/error/failures.dart';

// Abstract contract — the domain layer only knows about this interface,
// NOT the implementation detail (Dio, HTTP, etc.)
abstract class AuthRepository {
  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  });


  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}
