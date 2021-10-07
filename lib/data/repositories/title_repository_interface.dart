import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';

abstract class TitleRepositoryInterface {
  Future<List<TitleModel>> getMovieTvList(
      {Map<String, dynamic>? params, bool isTvShow = false});

  Future<List<TitleModel>> getMovieTvPopularList(
      {Map<String, dynamic>? params, bool isTvShow = false});

  Future<List<TitleModel>> getMovieUpcomingList({Map<String, dynamic>? params});

  Future<List<TitleModel>> getTitleRecommendation(String id,
      {bool isTvShow = false});

  Future<TitleDetailModel?> getTitleDetails(int id, {bool isTvShow = false});

  Future<bool> saveComment(int titleId, String text, {bool isTvShow = false});

  Future<bool> removeComment(int titleId, int commentId,
      {bool isTvShow = false});

  Future<int> getTitleRate(int titleId, {bool isTvShow = false});

  Future<bool> saveTitleRate(int titleId, int rate, {bool isTvShow = false});

  Future<List<TitleRatedModel>> getUserRatedTitleList({String? userId});

  Future<List<CommentModel>> getTitleComments(int titleId,
      {bool isTvShow = false});
}
