import 'package:blog_bloc_app/core/error/failures.dart';
import 'package:blog_bloc_app/core/usecase/usecase.dart';
import 'package:blog_bloc_app/core/common/entities/user.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
