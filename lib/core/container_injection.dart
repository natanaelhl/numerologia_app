import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ricardo_peres/core/auth_service.dart';
import 'package:ricardo_peres/core/database_service.dart';
import 'package:ricardo_peres/data/datasources/auth/auth_datasource.dart';
import 'package:ricardo_peres/data/datasources/auth/auth_datasource_impl.dart';
import 'package:ricardo_peres/data/datasources/lista_pessoas/lista_pessoas_datasource.dart';
import 'package:ricardo_peres/data/datasources/lista_pessoas/lista_pessoas_datasource_impl.dart';
import 'package:ricardo_peres/data/network/network_info.dart';
import 'package:ricardo_peres/data/repositories/auth/auth_repository_impl.dart';
import 'package:ricardo_peres/data/repositories/lista_pessoas/lista_pessoas_repository_impl.dart';
import 'package:ricardo_peres/domain/repositories/auth/auth_repository.dart';
import 'package:ricardo_peres/domain/repositories/lista_pessoas/lista_pessoas_repository.dart';
import 'package:ricardo_peres/domain/usecases/auth/auth_sign_in_usecase.dart';
import 'package:ricardo_peres/domain/usecases/auth/auth_sign_up_usecase.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/add_pessoa_usecase.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/delete_pessoa.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/fetch_lista_pessoas_usecase.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_bloc.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_bloc.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> setupContainer() async {
  getIt.registerLazySingleton(() => DatabaseService());

  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connection: getIt()));

  listaPessoas();
  auth();
  splash();
}

void splash (){
  getIt.registerFactory(() => SplashBloc(authService: getIt()));
}

void auth() {
  getIt.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(authService: getIt()));

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton<AuthSignInUsecase>(() => AuthSignInUsecase(repository: getIt()));
  getIt.registerLazySingleton<AuthSignUpUsecase>(() => AuthSignUpUsecase(repository: getIt()));

  getIt.registerFactory(() => AuthBloc(authSignIn: getIt(), authSignUp: getIt()));
}

void listaPessoas() {
  getIt.registerLazySingleton<ListaPessoasDatasource>(() =>
      ListaPessoasDatasourceImpl(dbService: getIt(), authService: getIt()));

  getIt.registerLazySingleton<ListaPessoasRepository>(() =>
      ListaPessoasRepositoryImpl(datasource: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton<FetchListaPessoasUsecase>(
      () => FetchListaPessoasUsecase(repository: getIt()));
  getIt.registerLazySingleton<DeletePessoaUsecase>(
      () => DeletePessoaUsecase(repository: getIt()));
  getIt.registerLazySingleton<AddPessoaUsecase>(
      () => AddPessoaUsecase(repository: getIt()));

  getIt.registerFactory(() => ListaPessoasBloc(
      fetchListaPessoas: getIt(), deletePessoa: getIt(), addpessoa: getIt()));
}
