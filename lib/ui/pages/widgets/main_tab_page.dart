import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_gesture_detector.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';
import 'package:my_movies_list/ui/widgets/custom_carrousel.dart';

class MainTabPage extends StatelessWidget {
  final _repository = getIt.get<TitleRepositoryInterface>();
  MainTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: ListView(
        children: [
          FutureBuilder<List<TitleModel>>(
            future: _repository.getTvMovieList(isTvShow: true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Series',
                scrollDirection: Axis.horizontal,
                children: movies!.isEmpty
                    ? [const LoadingCircularProgress()]
                    : movies
                        .map((e) => CustomGestureDetector(titleModel: e))
                        .toList(),
              );
            },
          ),
          FutureBuilder<List<TitleModel>>(
            future: _repository.getTvMovieList(isTvShow: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Filmes',
                scrollDirection: Axis.horizontal,
                children: movies!.isEmpty
                    ? [const LoadingCircularProgress()]
                    : movies
                        .map((e) => CustomGestureDetector(titleModel: e))
                        .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
