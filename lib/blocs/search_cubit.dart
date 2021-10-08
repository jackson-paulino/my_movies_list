import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchProcessingState extends SearchState {}

class SearchSuccessState extends SearchState {
  List<TitleModel> titles;

  SearchSuccessState(this.titles);
}

class SearchCubit extends Cubit<SearchState> {
  final TitleRepositoryInterface _titleRepository;
  final AppUri _appUri = AppUri();

  SearchCubit(this._titleRepository) : super(SearchInitialState());

  final List<TitleModel> _moviesList = [];
  int _pageNumber = 0;
  int totalPage = 0;
  String _previousName = '';

  void clearSession() {
    _pageNumber = 0;
    totalPage = 0;
    _moviesList.clear();
  }

  Future<void> getMovieList(String name) async {
    if (name.isEmpty) {
      clearSession();
      emit(SearchInitialState());
    } else {
      if (name != _previousName) {
        clearSession();
        _previousName = name;
      }

      if (totalPage == 0) {
        totalPage = await _titleRepository
            .getCountList(_appUri.isUriSearch(false), params: {'name': name});
      }

      if (_pageNumber == 0) {
        emit(SearchProcessingState());
      }

      if (_moviesList.length < totalPage) {
        _pageNumber++;
        var response = await _titleRepository.getMovieTvList(
            _appUri.isUriSearch(true),
            params: {'name': name, 'page': _pageNumber});

        _moviesList.addAll(response);
        emit(SearchSuccessState(_moviesList));
      }
    }
  }
}
