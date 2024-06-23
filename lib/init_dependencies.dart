import 'package:blog_bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_bloc_app/core/secrets/app_secrets.dart';
import 'package:blog_bloc_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:blog_bloc_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
// DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
      ),
    )

    // UseCases
    ..registerFactory<UserSignUp>(
      () => UserSignUp(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory<CurrentUser>(
        () => CurrentUser(serviceLocator<AuthRepository>()))

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
          userSignUp: serviceLocator<UserSignUp>(),
          userLogin: serviceLocator<UserLogin>(),
          currentUser: serviceLocator<CurrentUser>(),
          appUserCubit: serviceLocator<AppUserCubit>()),
    );
}
