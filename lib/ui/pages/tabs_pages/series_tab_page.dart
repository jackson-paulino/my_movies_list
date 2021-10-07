import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/genres_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_list_future.dart';

class SeriesTabPage extends StatelessWidget {
  final _repository = getIt.get<TitleRepositoryInterface>();

  SeriesTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListView(
        children: <GenresModel>[
          GenresModel(id: 16, name: 'Animação'),
          GenresModel(id: 18, name: 'Drama'),
          GenresModel(id: 99, name: 'Documentário'),
        ]
            .map<Widget>(
              (e) => BuilderListFuture(
                label: e.name,
                listFuture: _repository
                    .getMovieTvList(isTvShow: true, params: {'genre': e.id}),
              ),
            )
            .toList(),
      ),
    );
  }
}
