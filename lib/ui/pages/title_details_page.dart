import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/tilte_recommencation.dart';
import 'package:my_movies_list/blocs/title_comment_cubit.dart';
import 'package:my_movies_list/blocs/title_details_bloc.dart';
import 'package:my_movies_list/blocs/title_rate_cubit.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_carrousel.dart';
import 'package:my_movies_list/ui/widgets/custom_gesture_detector.dart';
import 'package:my_movies_list/ui/widgets/custom_network_image.dart';
import 'package:my_movies_list/ui/widgets/custom_rate_button.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';

class TitleDetailsPage extends StatelessWidget {
  const TitleDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleModel = ModalRoute.of(context)!.settings.arguments as TitleModel;
    return MultiBlocProvider(
      providers: [
        BlocProvider<TitleDetailsCubit>(
            create: (context) => TitleDetailsCubit(
                getIt.get<TitleRepositoryInterface>(),
                titleModel: titleModel)
              ..getTitleDetails()),
        BlocProvider<TitleRateCubit>(
            create: (context) => TitleRateCubit(
                  getIt.get<TitleRepositoryInterface>(),
                  titleModel: titleModel,
                )..getTitleRate()),
        BlocProvider(
            create: (context) => TitleDetailRecommendationCubit(
                getIt.get<TitleRepositoryInterface>(),
                titleModel: titleModel)
              ..getTitleRecommendation()),
        BlocProvider(
            create: (context) => TitleDetailCommentCubit(
                getIt.get<TitleRepositoryInterface>(),
                titleModel: titleModel)
              ..getTitleComments()),
      ],
      child: TitleDetailsView(),
    );
  }
}

class TitleDetailsView extends StatelessWidget {
  TitleDetailsView({Key? key}) : super(key: key);

  final _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          BlocBuilder<TitleDetailsCubit, TitleDetailsState>(
            builder: (context, state) {
              if (state is TitleDetailsNotData) {
                return const Center(child: Text('Nenhum dado'));
              } else if (state is TitleDetailLoadingState) {
                return const LoadingCircularProgress(text: 'Carregando');
              } else if (state is TitleDetailsLoadedState) {
                return CustomCarrousel(
                    scrollDirection: Axis.vertical,
                    children: [_buildDetalisMovies(state.titleDetail)]);
              } else {
                return const Center(
                    child: Text('Falha ao carregar os detalhes do titulo'));
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
        if (titleDetail.releaseDate != null)
          Text(
            'Estreia - ${DateFormat('dd/MM/yyyy').format(titleDetail.releaseDate!)}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        const SizedBox(height: 20.0),
        const Text('Sinopse:', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8.0),
        Text(titleDetail.overview,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 15.0)),
        const SizedBox(height: 20.0),
        Text('Duração ${titleDetail.runtime} min'),
        const SizedBox(height: 20.0),
        _listChip(titleDetail),
        _buildTitleRate(),
        _buildTitleRecommendations(),
        _buildTitleComments()
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

  Widget _buildTitleRate() {
    return BlocBuilder<TitleRateCubit, TitleRateState>(
      builder: (context, state) {
        if (state is TitleRateProcessingState) {
          return const Center(child: LoadingCircularProgress());
        }

        return CustomRateButton(
          value: state is TitleRateSuccessState ? (state.rate == 1) : null,
          onPressed: (bool value) {
            context.read<TitleRateCubit>().saveTitleRate(value ? 1 : -1);
          },
        );
      },
    );
  }

  Widget _buildTitleRecommendations() {
    return BlocBuilder<TitleDetailRecommendationCubit,
        TitleDetailRecommendationState>(
      builder: (context, state) {
        if (state is TitleDetailProcessingRecommendationState) {
          return const LoadingCircularProgress();
        }

        if (state is TitleDetailSuccessRecommendationState) {
          var recommendations = state.recommendations;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomCarrousel(
              label: 'Recomendados',
              children: recommendations
                  .map((e) => CustomGestureDetector(titleModel: e))
                  .toList(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildTitleComments() {
    return BlocListener<TitleDetailCommentCubit, TitleDetailCommentState>(
      listener: (context, state) {
        if (state is TitleDetailCommentByOtherUserState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exclusão não permitida ')));
          context.read<TitleDetailCommentCubit>().getTitleComments();
        }

        if (state is TitleDetailCommentFailState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Exclusão não permitida por esse usuário')));
          context.read<TitleDetailCommentCubit>().getTitleComments();
        }
      },
      child: BlocBuilder<TitleDetailCommentCubit, TitleDetailCommentState>(
        buildWhen: (previous, current) {
          return (current is TitleDetailCommentProcessingState ||
              current is TitleDetailCommentSuccessState);
        },
        builder: (context, state) {
          if (state is TitleDetailCommentProcessingState) {
            return const Center(child: LoadingCircularProgress());
          }

          if (state is TitleDetailCommentSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Comentários',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ...state.comments
                    .map(
                      (e) => e.text.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      e.text,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                    subtitle: Text(
                                      DateFormat('dd/MM/yyyy hh:mm:ss')
                                          .format(e.date),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => context
                                      .read<TitleDetailCommentCubit>()
                                      .removeComment(e.id),
                                  icon:
                                      const Icon(Icons.delete_outline_outlined),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    )
                    .toList(),
                const SizedBox(height: 10.0),
                BlocBuilder<TitleDetailCommentCubit, TitleDetailCommentState>(
                    builder: (context, state) {
                  return CustomTextField(
                    labelText: 'Adicione um comentário',
                    controller: _commentTextController,
                    comment: true,
                    onPressed: () {
                      context
                          .read<TitleDetailCommentCubit>()
                          .saveComment(_commentTextController.text);
                      _commentTextController.clear();
                    },
                  );
                }),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
