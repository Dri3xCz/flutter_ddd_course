// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_flutter_tdd_ddd/core/network/network_info.dart' as _i12;
import 'package:clean_flutter_tdd_ddd/core/store/app_epic.dart' as _i10;
import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart' as _i8;
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart' as _i4;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i9;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart'
    as _i11;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i14;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i13;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i15;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i16;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/data/number_trivia_data_epic.dart'
    as _i7;
import 'package:clean_flutter_tdd_ddd/injection_container.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.preferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i4.InputConverter>(() => _i4.InputConverter());
    gh.lazySingleton<_i5.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i6.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.lazySingleton<_i7.NumberTriviaEpic<_i8.AppState>>(
        () => registerModule.numberTriviaEpic);
    gh.lazySingleton<_i9.NumberTriviaLocalDataSource>(() =>
        _i9.NumberTriviaLocalDataSourceImpl(
            sharedPreferences: gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i10.AppEpic>(() => _i10.AppEpic(
        numberTriviaEpic: gh<_i7.NumberTriviaEpic<_i8.AppState>>()));
    gh.lazySingleton<_i11.NumberTriviaRemoteDataSource>(
        () => _i11.NumberTriviaRemoteDataSourceImpl(client: gh<_i5.Client>()));
    gh.lazySingleton<_i12.NetworkInfo>(
        () => _i12.NetworkInfoImpl(gh<_i6.InternetConnectionChecker>()));
    gh.lazySingleton<_i13.NumberTriviaRepository>(
        () => _i14.NumberTriviaRepositoryImpl(
              remoteDataSource: gh<_i11.NumberTriviaRemoteDataSource>(),
              localDataSource: gh<_i9.NumberTriviaLocalDataSource>(),
              networkInfo: gh<_i12.NetworkInfo>(),
            ));
    gh.lazySingleton<_i15.GetConcreteNumberTrivia>(
        () => _i15.GetConcreteNumberTrivia(gh<_i13.NumberTriviaRepository>()));
    gh.lazySingleton<_i16.GetRandomNumberTrivia>(
        () => _i16.GetRandomNumberTrivia(gh<_i13.NumberTriviaRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i17.RegisterModule {}
