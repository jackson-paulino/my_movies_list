import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/home_cubit.dart';
import 'package:my_movies_list/data/models/title_type.dart';
import 'custom_carrousel.dart';
import 'custom_gesture_detector.dart';
import 'loading_circular_progress.dart';

class BuilderListFuture extends StatelessWidget {
  final String? label;
  final List<TitleType> titleType;
  const BuilderListFuture({Key? key, this.label = '', required this.titleType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      children: titleType
          .map(
            (e) => BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (oldState, newState) {
                if (newState is HomeProcessingState) {
                  return newState.type.label == e.label;
                } else if (newState is HomeSuccessState) {
                  return newState.type.label == e.label;
                }
                return true;
              },
              builder: (context, state) {
                if (state is HomeProcessingState) {
                  return const Center(child: LoadingCircularProgress());
                }
                if (state is HomeSuccessState) {
                  return CustomCarrousel(
                    label: e.label,
                    scrollDirection: Axis.horizontal,
                    children: state.titles.isEmpty
                        ? [const Center(child: Text('Nenhum resulta'))]
                        : state.titles
                            .map((e) => CustomGestureDetector(titleModel: e))
                            .toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
          .toList(),
    );

    /*  BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (oldState, newState) {
        if(newState is HomeProcessingState){
          return newState.
        }
      },
      builder: (context, state) {
        if (state is HomeProcessingState) {
          return const Center(child: LoadingCircularProgress());
        }
        if (state is HomeSuccessState) {
          return CustomCarrousel(
            label: label,
            scrollDirection: Axis.horizontal,
            children: state.titles.isEmpty
                ? [const Center(child: Text('Nenhum resulta'))]
                : state.titles
                    .map((e) => CustomGestureDetector(titleModel: e))
                    .toList(),
          );
        } else {
          return Container();
        }
      },
    ); */
  }
}
