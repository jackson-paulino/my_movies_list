import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/home_cubit.dart';
import 'package:my_movies_list/data/models/title_type.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/widgets/custom_list_future.dart';

class SeriesTabPage extends StatelessWidget {
  const SeriesTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleList = [
      TitleType(paramsUrl: true, label: 'Animação', params: '16', isTvShow: true),
      TitleType(paramsUrl: true, label: 'Drama', params: '18', isTvShow: true),
      TitleType(
          paramsUrl: true, label: 'Documentário', params: '99', isTvShow: true)
    ];

    return BlocProvider(
        create: (_) => HomeCubit(getIt.get<TitleRepositoryInterface>())
          ..getList(titleList),
        child: BuilderListFuture(titleType: titleList));
  }
}
