import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/title_rate_cubit.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_rate_button.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';
import 'package:my_movies_list/ui/widgets/custom_network_image.dart';

class RatingTitlePage extends StatelessWidget {
  const RatingTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final map =
        (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {});
    return BlocProvider(
        create: (context) =>
            TitleRateCubit(getIt.get<TitleRepositoryInterface>())
              ..getUserRatedTitleList(userId: map['id']),
        child: RatingTitleView(user: map));
  }
}

class RatingTitleView extends StatelessWidget {
  final Map<String, dynamic>? user;
  const RatingTitleView({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.isNotEmpty
            ? 'Avaliações do ${user!['name']}'
            : 'Minhas avaliações'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: BlocBuilder<TitleRateCubit, TitleRateState>(
            builder: (context, state) {
              if (state is TitleRateProcessingState) {
                return const LoadingCircularProgress();
              }

              if (state is TitleRateNotRatedExceptionState) {
                return const Center(
                  child: Text('Falha ao carregar os títulos avaliados'),
                );
              }

              if (state is TitleRateSuccessRatedListState) {
                return Column(
                  children: state.ratings
                      .map((e) => _buildTitleCard(context: context, title: e))
                      .toList(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleCard(
      {required TitleRatedModel title,
      required BuildContext context,
      bool canRate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: CustomNetworkImage(url: title.posterUrl),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    title.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<TitleRateCubit, TitleRateState>(
            buildWhen: (previous, current) {
              if (current is TitleRateSuccessState) {
                return current.rate == title.id;
              }

              return true;
            },
            builder: (context, state) {
              bool? _rate = title.rate != null ? (title.rate == 1) : null;

              if (state is TitleRateSuccessState) {
                _rate = state.rate as bool?;
              }

              return CustomRateButton(
                value: _rate,
                onPressed: canRate
                    ? (bool value) => context
                        .read<TitleRateCubit>()
                        .saveTitleRate(value ? 1 : -1)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
