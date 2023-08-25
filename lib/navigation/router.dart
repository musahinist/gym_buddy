import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_buddy_flutter/features/landing/landing_page.dart';
import 'package:gym_buddy_flutter/features/search/presentation/cubit/exercise_cubit.dart';
import 'package:gym_buddy_flutter/features/search/presentation/view/search_page.dart';
import 'package:gym_buddy_flutter/features/workout/workout_page.dart';
import 'package:gym_buddy_flutter/navigation/screens.dart';
import 'package:gym_buddy_flutter/ui_kit/layout/bottom_navbar_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouter = GoRouter(
  initialLocation: Screens.landing.path,
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: Screens.landing.path,
      name: Screens.landing.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LandingPage(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavbarScaffold(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: Screens.search.path,
            name: Screens.search.name,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => ExerciseCubit(context.read())
                  ..searchExercise(
                    type: '',
                    muscle: 'biceps',
                  ),
                child: const SearchPage(),
              ),
            ),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Screens.workout.path,
            name: Screens.workout.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WorkOutPage(),
            ),
          ),
        ]),
      ],
    )
  ],
);
