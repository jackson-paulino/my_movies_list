import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/search_cubit.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_gesture_detector.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchCubit(getIt.get<TitleRepositoryInterface>()),
        child: SearchView());
  }
}

class SearchView extends StatelessWidget {
  final searchTextController = TextEditingController();
  final scrollController = ScrollController();

  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _scrollPosition() {
      final positionScroll = scrollController.position.pixels;
      final extentScroll = scrollController.position.maxScrollExtent;
      if (extentScroll - positionScroll <=
          context.read<SearchCubit>().totalPage) {
        context.read<SearchCubit>().getMovieList(searchTextController.text);
      }
    }

    scrollController.addListener(_scrollPosition);

    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          hintText: 'Pesquise aqui...',
          border: InputBorder.none,
          controller: searchTextController,
          colorTextEditDark: false,
          onFieldSubmitted: (value) => context
              .read<SearchCubit>()
              .getMovieList(searchTextController.text),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchProcessingState) {
            return const Center(child: LoadingCircularProgress());
          }
          if (state is SearchSuccessState) {
            return GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 7,
              crossAxisSpacing: 2.0,
              childAspectRatio: .59,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              children: state.titles
                  .map<Widget>((e) => CustomGestureDetector(titleModel: e))
                  .toList(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
