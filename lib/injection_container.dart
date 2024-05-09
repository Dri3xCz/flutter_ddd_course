import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/store/app_state.dart';
import 'features/number_trivia/presentation/store/number_trivia_epic.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  
  getIt.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker();

  @preResolve
  Future<SharedPreferences> preferences() => SharedPreferences.getInstance();
}
