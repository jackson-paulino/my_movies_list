import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';

import 'custom_carrousel.dart';
import 'custom_gesture_detector.dart';
import 'loading_circular_progress.dart';

class BuilderListFuture extends StatelessWidget {
  final String? label;
  final Future<List<TitleModel>> listFuture;
  const BuilderListFuture({
    Key? key,
    this.label = '',
    required this.listFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TitleModel>>(
      future: listFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingCircularProgress(text: 'Carregando');
        }
        final movies = snapshot.data;

        return CustomCarrousel(
          label: label,
          scrollDirection: Axis.horizontal,
          children: movies!.isEmpty
              ? [const Center(child: Text('Nenhum resulta'))]
              : movies
                  .map((e) => CustomGestureDetector(titleModel: e))
                  .toList(),
        );
      },
    );
  }
}
