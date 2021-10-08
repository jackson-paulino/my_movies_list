import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';

abstract class TitleRepositoryInterface {
  Future<List<TitleModel>> getMovieTvList(String uri,
      {Map<String, dynamic>? params});

  Future<List<TitleModel>> getTitleRecommendation(String uri);

  Future<TitleDetailModel?> getTitleDetails(String uri);

  Future<bool> saveComment(String uri, {required String text});

  Future<bool> removeComment(String uri);

  Future<int> getTitleRate(String uri);

  Future<bool> saveTitleRate(String uri, {required int rate});

  Future<List<TitleRatedModel>> getUserRatedTitleList(String uri);

  Future<List<CommentModel>> getTitleComments(String uri);

  Future<int> getCountList(String uri, {Map<String, dynamic>? params});
}
