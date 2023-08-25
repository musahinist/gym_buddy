import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../model/exercise.dart';
import 'package:http/http.dart' as http;

abstract class ExcerciseRepository {
  Future<List<Exercise>> getExercises(
    String? type,
    String? muscle,
  );
}

class ExerciseRepositoryImpl implements ExcerciseRepository {
  ExerciseRepositoryImpl();

  var client = http.Client();

  @override
  Future<List<Exercise>> getExercises(
    String? type,
    String? muscle,
  ) async {
    var url =
        Uri.https('exercises-by-api-ninjas.p.rapidapi.com', 'v1/exercises', {
      'type': type ?? '',
      'muscle': muscle ?? '',
    });

    final response = await client.get(url, headers: {
      'X-RapidAPI-Key': '6f1e629736msh350e0adf0e81681p13ddd3jsn0d0f2ba96845',
      'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
    });
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final exercises = json.decode(response.body) as List;
      return exercises.map((e) => Exercise.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
