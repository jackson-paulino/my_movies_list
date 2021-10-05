import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/title_details_exception.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';

enum TitleDetailsState { initial, processing, success, failed }

class TitleDetailsCubit extends Cubit<TitleDetailsState> {
  final TitleRepositoryInterface _titleRepository;
  final int id;
  TitleDetailsCubit(this._titleRepository, this.id)
      : super(TitleDetailsState.initial);

  Future<TitleDetailModel?> getTitleDetails() async {
    emit(TitleDetailsState.processing);
    try {
      await _titleRepository.getTitleDetalis(id);
      emit(TitleDetailsState.success);
    } on TitleDetailsException {
      emit(TitleDetailsState.failed);
    } on Exception {
      emit(TitleDetailsState.failed);
    }
  }
}
