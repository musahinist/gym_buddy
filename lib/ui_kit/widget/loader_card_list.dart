import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderCardList extends StatelessWidget {
  const LoaderCardList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      for (int i = 0; i < 10; i++)
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: const Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: SizedBox(
              height: 120,
            ),
          ),
        )
    ]));
  }
}
