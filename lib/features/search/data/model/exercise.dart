import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Exercise {
  final String? name;
  final String? type;
  final String? muscle;
  final String? equipment;
  final String? difficulty;
  final String? instructions;

  const Exercise({
    this.name,
    this.type,
    this.muscle,
    this.equipment,
    this.difficulty,
    this.instructions,
  });

  @override
  String toString() {
    return 'Exercise(name: $name, type: $type, muscle: $muscle, equipment: $equipment, difficulty: $difficulty, instructions: $instructions)';
  }

  factory Exercise.fromMap(Map<String, dynamic> data) => Exercise(
        name: data['name'] as String?,
        type: data['type'] as String?,
        muscle: data['muscle'] as String?,
        equipment: data['equipment'] as String?,
        difficulty: data['difficulty'] as String?,
        instructions: data['instructions'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'muscle': muscle,
        'equipment': equipment,
        'difficulty': difficulty,
        'instructions': instructions,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Exercise].
  factory Exercise.fromJson(String data) {
    return Exercise.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Exercise] to a JSON string.
  String toJson() => json.encode(toMap());

  Exercise copyWith({
    String? name,
    String? type,
    String? muscle,
    String? equipment,
    String? difficulty,
    String? instructions,
  }) {
    return Exercise(
      name: name ?? this.name,
      type: type ?? this.type,
      muscle: muscle ?? this.muscle,
      equipment: equipment ?? this.equipment,
      difficulty: difficulty ?? this.difficulty,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Exercise) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode ^
      muscle.hashCode ^
      equipment.hashCode ^
      difficulty.hashCode ^
      instructions.hashCode;
}
