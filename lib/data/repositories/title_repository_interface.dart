import 'package:my_movies_list/data/models/genres_model.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';

abstract class TitleRepositoryInterface {
  Future<List<GenresModel>> getGenres({String? movieId});

  Future<List<TitleModel>> getTvMovieList(
      {Map<String, dynamic>? params, bool isTvShow = false});

  Future<TitleDetailModel?> getTitleDetalis(int id, {bool isTvShow = false});

  Future<List<TitleModel>> getTvShowRecommendation(String id,
      {bool isTvShow = false});

  Future<bool> saveComment(int titleId, String text, {bool isTvShow = false});

  Future<bool> removeComment(int titleId, int commentId,
      {bool isTvShow = false});
}
