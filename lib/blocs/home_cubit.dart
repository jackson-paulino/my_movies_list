import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_type.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeProcessingState extends HomeState {
  final TitleType type;

  HomeProcessingState(this.type);
}

class HomeFailState extends HomeState {}

class HomeSuccessState extends HomeState {
  final TitleType type;
  final List<TitleModel> titles;
  HomeSuccessState(this.titles, this.type);
}

class HomeCubit extends Cubit<HomeState> {
  final TitleRepositoryInterface _titleRepository;
  final AppUri _appUri = AppUri();

  HomeCubit(this._titleRepository) : super(HomeInitialState());

  Future<void> getList(List<TitleType> listType) async {
    try {
      for (final item in listType) {
        emit(HomeProcessingState(item));
        var params = item.paramsUrl ? {'genre': item.params} : null;
        var response = await _titleRepository
            .getMovieTvList(_appUri.isUriGenres(item), params: params);
        emit(HomeSuccessState(response, item));
      }
    } catch (e) {
      emit(HomeFailState());
    }
  }
}
