import 'package:my_movies_list/data/exceptions/title_not_rated.dart';
import 'package:my_movies_list/data/models/title_delais_model.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_rated_model.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';

class TitleRepository implements TitleRepositoryInterface {
  final HttpService _httpService;

  TitleRepository(this._httpService);

  @override
  Future<List<TitleModel>> getMovieTvList(String uri,
      {Map<String, dynamic>? params}) async {
    var response = await _httpService.getRequest(uri, params: params);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<TitleDetailModel?> getTitleDetails(String uri) async {
    var response = await _httpService.getRequest(uri);
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
  Future<List<TitleModel>> getTitleRecommendation(String uri) async {
    var response = await _httpService.getRequest(uri);
    if (response.success) {
      List<dynamic> data = response.content!['data'];

      return List<TitleModel>.from(data.map((e) => TitleModel.fromJson(e)));
    }

    return [];
  }

  @override
  Future<bool> removeComment(String uri) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _httpService.deleteRequest(uri, headers: headers);

    return response.success;
  }

  @override
  Future<bool> saveComment(String uri, {required String text}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _httpService.postRequest(uri, {'comment': text},
        headers: headers);

    return response.success;
  }

  @override
  Future<List<CommentModel>> getTitleComments(String uri) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};

    var response = await _httpService.getRequest(uri, headers: headers);
    if (response.success) {
      List<dynamic> data = response.content!['data'];
      return List<CommentModel>.from(data.map((e) => CommentModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<int> getTitleRate(String uri) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};

    var response = await _httpService.getRequest(uri, headers: headers);

    if (response.success) {
      return response.content!['rate'];
    }

    if (response.statusCode == 404) {
      throw TitleNotRatedException();
    }

    throw Exception('Falha ao registrar a classificação');
  }

  @override
  Future<List<TitleRatedModel>> getUserRatedTitleList(String uri) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};

    var response = await _httpService.getRequest(uri, headers: headers);

    if (response.success) {
      List<dynamic> data = response.content!['data'];
      return List<TitleRatedModel>.from(
          data.map((e) => TitleRatedModel.fromJson(e)));
    }
    return [];
  }

  @override
  Future<bool> saveTitleRate(String uri, {required int rate}) async {
    final token = await getIt.get<UserRepositoryInferface>().getToken();
    final headers = {'Authorization': 'Bearer $token'};

    var response =
        await _httpService.postRequest(uri, {'rate': rate}, headers: headers);
    return response.success;
  }

  @override
  Future<int> getCountList(String uri, {Map<String, dynamic>? params}) async {
    var response = await _httpService.getRequest(uri, params: params);

    if (response.success) {
      return response.content!['count'];
    }

    return 0;
  }
}
