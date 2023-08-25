import 'package:bloc/bloc.dart';
import 'package:gym_buddy_flutter/features/search/data/model/exercise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_buddy_flutter/features/search/data/repository/exercise_repository.dart';
part 'exercise_state.dart';
part 'exercise_cubit.freezed.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExcerciseRepository _excerciseRepository;
  ExerciseCubit(
    this._excerciseRepository,
  ) : super(const ExerciseState.initial());

  Future<void> searchExercise({
    String? type,
    String? muscle,
  }) async {
    try {
      emit(const ExerciseState.loading());
      final result = await _excerciseRepository.getExercises(
        type,
        muscle,
      );
      emit(ExerciseState.loaded(result));
    } catch (e) {
      emit(ExerciseState.error(e.toString()));
    }
  }
}
