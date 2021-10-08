import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

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
  final TitleRepositoryInterface _repository;
  final TitleModel titleModel;
  final AppUri _appUri = AppUri();

  TitleDetailRecommendationCubit(this._repository, {required this.titleModel})
      : super(TitleDetailProcessingRecommendationState());

  Future<void> getTitleRecommendation() async {
    emit(TitleDetailProcessingRecommendationState());

    var response = await _repository
        .getTitleRecommendation(_appUri.isUriRecommendation(titleModel));
    emit(TitleDetailSuccessRecommendationState(response));
  }
}
