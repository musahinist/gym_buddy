part of 'exercise_cubit.dart';

@freezed
abstract class ExerciseState with _$ExerciseState {
  const factory ExerciseState.initial() = _Initial;
  const factory ExerciseState.loading() = _Loading;
  const factory ExerciseState.loaded(List<Exercise> exercises) = _Loaded;
  const factory ExerciseState.error(String message) = _Error;
}
