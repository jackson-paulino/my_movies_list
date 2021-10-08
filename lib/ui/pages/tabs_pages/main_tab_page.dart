import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/home_cubit.dart';
import 'package:my_movies_list/data/models/title_type.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_list_future.dart';

class MainTabPage extends StatelessWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleList = [
      TitleType(
          paramsUrl: false,
          label: 'Filmes Recentes',
          params: 'upcoming',
          isTvShow: false),
      TitleType(
          paramsUrl: false,
          label: 'Filmes Populares',
          params: 'popular',
          isTvShow: false),
      TitleType(
          paramsUrl: false,
          label: 'Séries Populares',
          params: 'popular',
          isTvShow: true)
    ];

    return BlocProvider(
        create: (_) => HomeCubit(getIt.get<TitleRepositoryInterface>())
          ..getList(titleList),
        child: BuilderListFuture(titleType: titleList));
  }
}
