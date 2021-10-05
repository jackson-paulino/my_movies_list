import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_carrousel.dart';
import 'package:my_movies_list/ui/widgets/custom_network_image.dart';
import 'package:my_movies_list/ui/widgets/custom_rate_button.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';

class TitleDetailsPage extends StatelessWidget {
  final _repository = getIt.get<TitleRepositoryInterface>();
  TitleDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as TitleModel;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FutureBuilder<TitleDetailModel?>(
            future: _repository.getTitleDetalis(title.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingCircularProgress(text: 'Conectando');
              }
              if (snapshot.hasData) {
                final movies = snapshot.data;
                return CustomCarrousel(
                    scrollDirection: Axis.vertical,
                    children: [_buildDetalisMovies(movies!)]);
              } else {
                return const LoadingCircularProgress(text: 'Nenhum Dados');
              }
            },
          ),
        ],
      ),
    );
  }

  Column _buildDetalisMovies(TitleDetailModel titleDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(url: titleDetail.coverUrl),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildDetails(titleDetail),
        ),
      ],
    );
  }

  Column _buildDetails(TitleDetailModel titleDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleDetail.name,
            style:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
        const SizedBox(height: 20.0),
        const Text('Sinopse:', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 20.0),
        Text(titleDetail.overview, style: const TextStyle(fontSize: 15.0)),
        const SizedBox(height: 20.0),
        Text('Duração ${titleDetail.runtime} min'),
        const SizedBox(height: 20.0),
        _listChip(titleDetail),
        const CustomRateButton(value: true)
      ],
    );
  }

  Widget _listChip(TitleDetailModel titleDetail) {
    return Wrap(
        children: titleDetail.genres!
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Chip(
                    label: Text(e.name),
                  ),
                ))
            .toList());
  }
}
