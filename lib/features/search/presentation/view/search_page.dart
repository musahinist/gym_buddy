import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_buddy_flutter/constant/asset.dart';
import 'package:gym_buddy_flutter/features/search/data/model/exercise.dart';
import 'package:gym_buddy_flutter/features/search/presentation/cubit/exercise_cubit.dart';
import 'package:gym_buddy_flutter/ui_kit/layout/base_scaffold.dart';
import 'package:gym_buddy_flutter/ui_kit/widget/loader_card_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          toolbarHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                height: 120,
                child: const Text('Search Exercise')),
            background: Image.network(Asset.backgroundImage, fit: BoxFit.cover),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(72.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBarWidget(),
            ),
          ),
        ),
        // add sliver list builder
        BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              loaded: (state) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${state.exercises.length} item found',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                );
              },
            );
          },
        ),
        BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const LoaderCardList(),
              loaded: (state) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CardListTile(exercise: state.exercises[index]);
                    },
                    childCount: state.exercises.length,
                  ),
                );
              },
            );
          },
        ),
      ],
    ));
  }
}

class CardListTile extends StatelessWidget {
  const CardListTile({
    super.key,
    required this.exercise,
  });
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.name!),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              margin: const EdgeInsets.fromLTRB(0, 8, 4, 8),
              decoration: const ShapeDecoration(
                color: Colors.grey,
                shape: StadiumBorder(),
              ),
              child: Text(exercise.type!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
            ),
            Text(exercise.muscle!),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  List<String> type = [
    'cardio',
    'olympic_weightlifting',
    'plyometrics',
    'powerlifting',
    'strength',
    'stretching',
    'strongman'
  ];

  List<String> muscle = [
    'abdominals',
    'abductors',
    'adductors',
    'biceps',
    'calves',
    'chest',
    'forearms',
    'glutes',
    'hamstrings',
    'lats',
    'lower_back',
    'middle_back',
    'neck',
    'quadriceps',
    'traps',
    'triceps'
  ];

  List<String> combinedList = [];

  List<String> filterList = ['type', 'muscle'];
  Set<String> selectedFilter = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    combinedList = [...type, ...muscle];
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            Tooltip(
                message: 'Change filter mode',
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.tune_outlined),
                  onSelected: (String value) {
                    setState(() {
                      if (selectedFilter.contains(value)) {
                        selectedFilter.remove(value);
                      } else {
                        selectedFilter.add(value);
                      }
                    });
                    if (selectedFilter.contains('type') &&
                        selectedFilter.contains('muscle')) {
                      combinedList = [...type, ...muscle];
                    } else if (selectedFilter.contains('type')) {
                      combinedList = [...type];
                    } else if (selectedFilter.contains('muscle')) {
                      combinedList = [...muscle];
                    } else {
                      combinedList = combinedList = [...type, ...muscle];
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<String>>[
                      for (int i = 0; i < filterList.length; i++)
                        PopupMenuItem<String>(
                            value: filterList[i],
                            child: Row(
                              children: [
                                Checkbox(
                                    value:
                                        selectedFilter.contains(filterList[i]),
                                    onChanged: (bool? value) {}),
                                Text(filterList[i])
                              ],
                            ))
                    ];
                  },
                ))
          ],
        );
      },
      suggestionsBuilder: (_, SearchController controller) {
        combinedList.sort();
        if (controller.text.isEmpty) {
          return List<ListTile>.generate(combinedList.length, (int index) {
            return ListTile(
              title: Text(combinedList[index]),
              onTap: () {
                setState(() {
                  controller.closeView(combinedList[index]);
                  if (type.contains(combinedList[index])) {
                    context.read<ExerciseCubit>().searchExercise(
                          type: combinedList[index],
                        );
                  } else {
                    context.read<ExerciseCubit>().searchExercise(
                          muscle: combinedList[index],
                        );
                  }
                });
              },
            );
          });
        } else {
          List<String> containsList = combinedList
              .where((element) => element.contains(controller.text))
              .toList();
          return List<ListTile>.generate(containsList.length, (int index) {
            return ListTile(
              title: Text(containsList[index]),
              onTap: () {
                setState(() {
                  controller.closeView(containsList[index]);
                  if (type.contains(containsList[index])) {
                    context.read<ExerciseCubit>().searchExercise(
                          type: containsList[index],
                        );
                  } else {
                    context.read<ExerciseCubit>().searchExercise(
                          muscle: containsList[index],
                        );
                  }
                });
              },
            );
          });
        }
      },
    );
  }
}
