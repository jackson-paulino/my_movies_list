import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';
import 'package:my_movies_list/ui/widgets/custom_carrousel.dart';
import 'package:my_movies_list/ui/widgets/custom_gesture_detector.dart';

class SeriesTabPage extends StatelessWidget {
  final _repository = getIt.get<TitleRepositoryInterface>();

  SeriesTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListView(
        children: [
          FutureBuilder<List<TitleModel>>(
            future: _repository
                .getTvMovieList(isTvShow: true, params: {'genre': 10749}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Romance',
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
            future: _repository
                .getTvMovieList(isTvShow: true, params: {'genre': 16}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Animação',
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
            future: _repository
                .getTvMovieList(isTvShow: true, params: {'genre': 27}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Terror',
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
            future: _repository
                .getTvMovieList(isTvShow: true, params: {'genre': 80}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando');
              }
              final movies = snapshot.data;

              return CustomCarrousel(
                label: 'Crime',
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
