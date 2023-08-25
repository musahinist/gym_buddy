import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_buddy_flutter/features/search/data/repository/exercise_repository.dart';

import 'navigation/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ExcerciseRepository>(
      create: (context) => ExerciseRepositoryImpl(),
      child: MaterialApp.router(
        title: 'Gym Buddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
