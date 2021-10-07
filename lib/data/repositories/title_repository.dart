import 'package:my_movies_list/data/exceptions/title_not_rated.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_string.dart';

class TitleRepository implements TitleRepositoryInterface {
  final HttpService _httpService;
  static const _baseUrl = Strings.movieApiUrl;

  TitleRepository(this._httpService);

  String typeIsTvShow(bool isTvShow) => isTvShow ? 'tv' : 'movies';

  @override
  Future<List<TitleModel>> getMovieTvList(
      {Map<String, dynamic>? params, bool isTvShow = false}) async {
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}';
    var response = await _httpService.getRequest(url, params: params);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<TitleDetailModel?> getTitleDetails(int id,
      {bool isTvShow = false}) async {
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$id';
    var response = await _httpService.getRequest(url);
    if (response.success) {
      var data = response.content!;

      return TitleDetailModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      throw TitleNotRatedException();
    }

    throw Exception('Falha ao pesquisa detalhes');
  }

  @override
  Future<List<TitleModel>> getTitleRecommendation(String id,
      {bool isTvShow = false}) async {
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$id/recommendations';
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
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final url =
        '$_baseUrl/${typeIsTvShow(isTvShow)}/$titleId/$commentId/comment';
    final response = await _httpService.deleteRequest(url, headers: headers);

    return response.success;
  }

  @override
  Future<bool> saveComment(int titleId, String text,
      {bool isTvShow = false}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$titleId/comment';
    final response = await _httpService.postRequest(url, {'comment': text},
        headers: headers);

    return response.success;
  }

  @override
  Future<List<TitleModel>> getMovieTvPopularList(
      {Map<String, dynamic>? params, bool isTvShow = false}) async {
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/popular';
    var response = await _httpService.getRequest(url, params: params);

    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<List<TitleModel>> getMovieUpcomingList(
      {Map<String, dynamic>? params}) async {
    const url = '$_baseUrl/movies/upcoming';
    var response = await _httpService.getRequest(url, params: params);

    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<List<CommentModel>> getTitleComments(int titleId,
      {bool isTvShow = false}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$titleId/comments';

    var response = await _httpService.getRequest(url, headers: headers);
    if (response.success) {
      List<dynamic> data = response.content!['data'];
      return List<CommentModel>.from(data.map((e) => CommentModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<int> getTitleRate(int titleId, {bool isTvShow = false}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$titleId/rate';

    var response = await _httpService.getRequest(url, headers: headers);

    if (response.success) {
      return response.content!['rate'];
    }

    if (response.statusCode == 404) {
      throw TitleNotRatedException();
    }

    throw Exception('Falha ao registrar a classificação');
  }

  @override
  Future<List<TitleRatedModel>> getUserRatedTitleList({String? userId}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    var userParams = '';

    if (userId != null) {
      userParams = '/$userId';
    }

    final url = '$_baseUrl/users$userParams/titles-rated';

    var response = await _httpService.getRequest(url, headers: headers);

    if (response.success) {
      List<dynamic> data = response.content!['data'];
      return List<TitleRatedModel>.from(
          data.map((e) => TitleRatedModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<bool> saveTitleRate(int titleId, int rate,
      {bool isTvShow = false}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final url = '$_baseUrl/${typeIsTvShow(isTvShow)}/$titleId/rate';

    var response =
        await _httpService.postRequest(url, {'rate': rate}, headers: headers);
    return response.success;
  }
}
