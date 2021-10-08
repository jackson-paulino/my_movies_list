import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/title_details_exception.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

class TitleDetailsState {}

class TitleDetailLoadingState extends TitleDetailsState {}

class TitleDetailsLoadedState extends TitleDetailsState {
  final TitleDetailModel titleDetail;

  TitleDetailsLoadedState(this.titleDetail);
}

class TitleDetailsFailed extends TitleDetailsState {}

class TitleDetailsNotData extends TitleDetailsState {}

class TitleDetailsCubit extends Cubit<TitleDetailsState> {
  final TitleRepositoryInterface _titleRepository;
  final TitleModel titleModel;
  final AppUri _appUri = AppUri();

  TitleDetailsCubit(this._titleRepository, {required this.titleModel})
      : super(TitleDetailLoadingState());

  Future<TitleDetailModel?> getTitleDetails() async {
    try {
      var response = await _titleRepository
          .getTitleDetails(_appUri.isUriDetails(titleModel));
      emit(TitleDetailsLoadedState(response!));
    } on TitleDetailsException {
      emit(TitleDetailsNotData());
    } on Exception {
      emit(TitleDetailsFailed());
    }
  }
}
