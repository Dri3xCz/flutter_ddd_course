import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/number_trivia.dart';
import '../models/number_trivia_model.dart';

import 'number_trivia_mapper.auto_mappr.dart';

@lazySingleton
@AutoMappr([
  MapType<NumberTriviaModel, NumberTrivia>(),
])
class NumberTriviaMapper extends $NumberTriviaMapper {}
