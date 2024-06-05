import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/number_trivia.dart';

part 'number_trivia_model.freezed.dart';
part 'number_trivia_model.g.dart';

@freezed
class NumberTriviaModel with _$NumberTriviaModel {
  const factory NumberTriviaModel({
    required String text,
    required int number,
  }) = _NumberTriviaModel;

  const NumberTriviaModel._();

  factory NumberTriviaModel.fromJson(Map<String, Object?> json) =>
      _$NumberTriviaModelFromJson(json);
}
