import 'package:flutter/material.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_list_future.dart';

class MainTabPage extends StatelessWidget {
  final _repository = getIt.get<TitleRepositoryInterface>();
  MainTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: ListView(
        children: [
          BuilderListFuture(
            label: 'Filmes Recentes',
            listFuture: _repository.getMovieUpcomingList(),
          ),
          BuilderListFuture(
            label: 'Filmes Populares',
            listFuture: _repository.getMovieTvPopularList(),
          ),
          BuilderListFuture(
            label: 'Séries Populares',
            listFuture: _repository.getMovieTvPopularList(isTvShow: true),
          ),
        ],
      ),
    );
  }
}
