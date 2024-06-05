// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_flutter_tdd_ddd/core/network/network_info.dart' as _i13;
import 'package:clean_flutter_tdd_ddd/core/store/app_epic.dart' as _i11;
import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart' as _i8;
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart' as _i4;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i10;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart'
    as _i12;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/mapper/number_trivia_mapper.dart'
    as _i9;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i15;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i14;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i16;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i17;
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/data/number_trivia_data_epic.dart'
    as _i7;
import 'package:clean_flutter_tdd_ddd/injection_container.dart' as _i18;
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
    gh.lazySingleton<_i9.NumberTriviaMapper>(() => _i9.NumberTriviaMapper());
    gh.lazySingleton<_i10.NumberTriviaLocalDataSource>(() =>
        _i10.NumberTriviaLocalDataSourceImpl(
            sharedPreferences: gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i11.AppEpic>(() => _i11.AppEpic(
        numberTriviaEpic: gh<_i7.NumberTriviaEpic<_i8.AppState>>()));
    gh.lazySingleton<_i12.NumberTriviaRemoteDataSource>(
        () => _i12.NumberTriviaRemoteDataSourceImpl(client: gh<_i5.Client>()));
    gh.lazySingleton<_i13.NetworkInfo>(
        () => _i13.NetworkInfoImpl(gh<_i6.InternetConnectionChecker>()));
    gh.lazySingleton<_i14.NumberTriviaRepository>(
        () => _i15.NumberTriviaRepositoryImpl(
              remoteDataSource: gh<_i12.NumberTriviaRemoteDataSource>(),
              localDataSource: gh<_i10.NumberTriviaLocalDataSource>(),
              networkInfo: gh<_i13.NetworkInfo>(),
              numberTriviaMapper: gh<_i9.NumberTriviaMapper>(),
            ));
    gh.lazySingleton<_i16.GetConcreteNumberTrivia>(
        () => _i16.GetConcreteNumberTrivia(gh<_i14.NumberTriviaRepository>()));
    gh.lazySingleton<_i17.GetRandomNumberTrivia>(
        () => _i17.GetRandomNumberTrivia(gh<_i14.NumberTriviaRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
