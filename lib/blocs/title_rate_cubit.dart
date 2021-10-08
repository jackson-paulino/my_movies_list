import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/title_not_rated.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

abstract class TitleRateState {}

class TitleRateProcessingState extends TitleRateState {}

class TitleRateSuccessState extends TitleRateState {
  final int rate;

  TitleRateSuccessState(this.rate);

  int get props => rate;
}

class TitleRateNotRatedExceptionState extends TitleRateState {}

class TitleRateSuccessRatedListState implements TitleRateState {
  List<TitleRatedModel> ratings;

  TitleRateSuccessRatedListState(this.ratings);

  List<TitleRatedModel> get props => ratings;
}

class TitleRateCubit extends Cubit<TitleRateState> {
  final TitleRepositoryInterface _repository;
  final TitleModel? titleModel;
  final AppUri _appUri = AppUri();

  TitleRateCubit(this._repository, {this.titleModel})
      : super(TitleRateProcessingState());

  Future<void> getUserRatedTitleList({String? userId}) async {
    emit(TitleRateProcessingState());

    try {
      var response = await _repository
          .getUserRatedTitleList(_appUri.isUriUserRate(userId));
      emit(TitleRateSuccessRatedListState(response));
    } catch (e) {
      emit(TitleRateNotRatedExceptionState());
    }
  }

  Future<void> getTitleRate() async {
    emit(TitleRateProcessingState());

    try {
      var rate = await _repository.getTitleRate(_appUri.isUriRate(titleModel!));
      emit(TitleRateSuccessState(rate));
    } on TitleNotRatedException {
      emit(TitleRateNotRatedExceptionState());
    }
  }

  Future<void> saveTitleRate(int rate) async {
    emit(TitleRateProcessingState());

    await _repository.saveTitleRate(_appUri.isUriSaveRate(titleModel!),
        rate: rate);
    emit(TitleRateSuccessState(rate));
  }
}
