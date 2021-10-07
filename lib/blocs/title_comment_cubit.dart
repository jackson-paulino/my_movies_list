import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/comment_by_other_user_exception.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';

abstract class TitleDetailCommentState {}

class TitleDetailCommentProcessingState extends TitleDetailCommentState {}

class TitleDetailCommentSuccessState extends TitleDetailCommentState {
  final List<CommentModel> comments;

  TitleDetailCommentSuccessState(this.comments);

  List<CommentModel> get props => comments;
}

class TitleDetailCommentFailState extends TitleDetailCommentState {
  final List<CommentModel> comments;

  TitleDetailCommentFailState(this.comments);

  List<CommentModel> get props => comments;
}

class TitleDetailCommentByOtherUserState extends TitleDetailCommentState {}

class TitleDetailCommentCubit extends Cubit<TitleDetailCommentState> {
  final TitleModel titleModel;
  final TitleRepositoryInterface _repository;

  TitleDetailCommentCubit(this._repository, {required this.titleModel})
      : super(TitleDetailCommentProcessingState());

  Future<void> getTitleComments() async {
    emit(TitleDetailCommentProcessingState());

    try {
      var response = await _repository.getTitleComments(titleModel.id,
          isTvShow: titleModel.isTvShow);
      emit(TitleDetailCommentSuccessState(response));
    } catch (e) {
      var response = await _repository.getTitleComments(titleModel.id,
          isTvShow: titleModel.isTvShow);
      emit(TitleDetailCommentFailState(response));
    }
  }

  Future<void> removeComment(int commentId) async {
    emit(TitleDetailCommentProcessingState());

    try {
      var success = await _repository.removeComment(titleModel.id, commentId,
          isTvShow: titleModel.isTvShow);

      if (success) {
        var response = await _repository.getTitleComments(titleModel.id,
            isTvShow: titleModel.isTvShow);
        emit(TitleDetailCommentSuccessState(response));
      } else {
        var response = await _repository.getTitleComments(titleModel.id,
            isTvShow: titleModel.isTvShow);
        emit(TitleDetailCommentFailState(response));
      }
    } on CommentByOtherUserException {
      emit(TitleDetailCommentByOtherUserState());
    } catch (e) {
      var response = await _repository.getTitleComments(titleModel.id,
          isTvShow: titleModel.isTvShow);
      emit(TitleDetailCommentFailState(response));
    }
  }

  Future<void> saveComment(String comment) async {
    emit(TitleDetailCommentProcessingState());

    try {
      var success = await _repository.saveComment(titleModel.id, comment,
          isTvShow: titleModel.isTvShow);

      if (success) {
        var response = await _repository.getTitleComments(titleModel.id,
            isTvShow: titleModel.isTvShow);
        emit(TitleDetailCommentSuccessState(response));
      } else {
        var response = await _repository.getTitleComments(titleModel.id,
            isTvShow: titleModel.isTvShow);
        emit(TitleDetailCommentFailState(response));
      }
    } catch (e) {
      var response = await _repository.getTitleComments(titleModel.id,
          isTvShow: titleModel.isTvShow);
      emit(TitleDetailCommentFailState(response));
    }
  }
}
