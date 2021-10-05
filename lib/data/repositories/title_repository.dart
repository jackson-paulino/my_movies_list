import 'package:my_movies_list/data/models/genres_model.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';
import 'package:my_movies_list/ui/shared/app_string.dart';

class TitleRepository implements TitleRepositoryInterface {
  final HttpService _httpService;
  static const _baseUrl = Strings.movieApiUrl;

  TitleRepository(this._httpService);

  @override
  Future<List<GenresModel>> getGenres({String? movieId}) async {
    var url = '$_baseUrl/genres';
    var response = await _httpService.getRequest(url);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<GenresModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<List<TitleModel>> getTvMovieList(
      {Map<String, dynamic>? params, bool isTvShow = false}) async {
    final titleType = isTvShow ? '/tv' : '/movies';
    final url = '$_baseUrl/$titleType';
    var response = await _httpService.getRequest(url, params: params);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<TitleDetailModel?> getTitleDetalis(int id,
      {bool isTvShow = false}) async {
    final titleType = isTvShow ? '/tv' : '/movies';
    final url = '$_baseUrl/$titleType/$id';
    var response = await _httpService.getRequest(url);
    if (response.success) {
      var data = response.content!;

      return TitleDetailModel.fromJson(data);
    }

    return null;
  }

  @override
  Future<List<TitleModel>> getTvShowRecommendation(String id,
      {bool isTvShow = false}) async {
    final titleType = isTvShow ? '/tv' : '/movies';
    final url = '$_baseUrl/$titleType/$id/recommendations';
    var response = await _httpService.getRequest(url);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<bool> removeComment(int titleId, int commentId,
      {bool isTvShow = false}) async {
    final titleType = isTvShow ? '/tv' : '/movies';
    final url = '$_baseUrl/$titleType/$titleId/$commentId/comment';
    final response = await _httpService.deleteRequest(url);

    return response.success;
  }

  @override
  Future<bool> saveComment(int titleId, String text,
      {bool isTvShow = false}) async {
    final titleType = isTvShow ? '/tv' : '/movies';
    final url = '$_baseUrl/$titleType/$titleId/comment';
    final response = await _httpService.postRequest(url, {'comment': text});

    return response.success;
  }
}
