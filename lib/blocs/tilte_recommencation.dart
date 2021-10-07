import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';

abstract class TitleDetailRecommendationState {}

class TitleDetailProcessingRecommendationState
    implements TitleDetailRecommendationState {}

class TitleDetailSuccessRecommendationState
    implements TitleDetailRecommendationState {
  final List<TitleModel> recommendations;

  TitleDetailSuccessRecommendationState(this.recommendations);

  List<TitleModel> get props => recommendations;
}

class TitleDetailRecommendationCubit
    extends Cubit<TitleDetailRecommendationState> {
  final TitleModel titleModel;
  final TitleRepositoryInterface _repository;

  TitleDetailRecommendationCubit(this._repository, {required this.titleModel})
      : super(TitleDetailProcessingRecommendationState());

  Future<void> getTitleRecommendation() async {
    emit(TitleDetailProcessingRecommendationState());

    var response = await _repository.getTitleRecommendation(
        titleModel.id.toString(),
        isTvShow: titleModel.isTvShow);
    emit(TitleDetailSuccessRecommendationState(response));
  }
}
