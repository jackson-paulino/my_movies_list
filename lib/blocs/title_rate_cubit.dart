import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/title_not_rated.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';

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
  final TitleModel? titleModel;
  final TitleRepositoryInterface _repository;

  TitleRateCubit(this._repository, {this.titleModel})
      : super(TitleRateProcessingState());

  Future<void> getUserRatedTitleList({String? userId}) async {
    emit(TitleRateProcessingState());

    try {
      var response = await _repository.getUserRatedTitleList(userId: userId);
      emit(TitleRateSuccessRatedListState(response));
    } catch (e) {
      emit(TitleRateNotRatedExceptionState());
    }
  }

  Future<void> getTitleRate() async {
    emit(TitleRateProcessingState());

    try {
      var rate = await _repository.getTitleRate(titleModel!.id,
          isTvShow: titleModel!.isTvShow);
      emit(TitleRateSuccessState(rate));
    } on TitleNotRatedException {
      emit(TitleRateNotRatedExceptionState());
    }
  }

  Future<void> saveTitleRate(int rate) async {
    emit(TitleRateProcessingState());

    await _repository.saveTitleRate(titleModel!.id, rate,
        isTvShow: titleModel!.isTvShow);
    emit(TitleRateSuccessState(rate));
  }
}
