import 'package:blog_bloc_app/core/error/failures.dart';
import 'package:blog_bloc_app/core/usecase/usecase.dart';
import 'package:blog_bloc_app/core/common/entities/user.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
