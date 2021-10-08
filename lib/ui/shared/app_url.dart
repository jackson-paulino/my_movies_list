import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/models/title_type.dart';

class AppUri {
  final String _movieApiUrl =
      'https://xbfuvqstcb.execute-api.us-east-1.amazonaws.com/dev';

  String baseUri() => _movieApiUrl;

  String _isTvShow(bool isTvShow) => isTvShow ? '/tv' : '/movies';

  String isUriSearch(bool value) => '$_movieApiUrl${_isTvShow(value)}';

  String isUriDetails(TitleModel title) =>
      '$_movieApiUrl${_isTvShow(title.isTvShow)}/${title.id}';

  String isUriRecommendation(TitleModel title) =>
      '$_movieApiUrl${_isTvShow(title.isTvShow)}/${title.id}/recommendations';

  String isUriGenres(TitleType type) {
    if (type.paramsUrl) {
      return '$_movieApiUrl${_isTvShow(type.isTvShow)}';
    } else {
      return '$_movieApiUrl${_isTvShow(type.isTvShow)}/${type.params}';
    }
  }

  String isUriComment(TitleModel title, {int? commentId}) {
    if (commentId != null) {
      return '$_movieApiUrl/${_isTvShow(title.isTvShow)}/${title.id}/$commentId/comment';
    } else {
      return '$_movieApiUrl/${_isTvShow(title.isTvShow)}/${title.id}/comment';
    }
  }

  String isUriListComments(TitleModel title) =>
      '$_movieApiUrl/${_isTvShow(title.isTvShow)}/${title.id}/comments';

  String isUriRate(TitleModel title) =>
      '$_movieApiUrl/${_isTvShow(title.isTvShow)}/${title.id}/rate';

  String isUriUserRate(String? userId) {
    if (userId != null) {
      return '$_movieApiUrl/users/$userId/titles-rated';
    } else {
      return '$_movieApiUrl/users/titles-rated';
    }
  }

  String isUriSaveRate(TitleModel title) =>
      '$_movieApiUrl/${_isTvShow(title.isTvShow)}/${title.id}/rate';

  String isUriUser() => '$_movieApiUrl/auth/me';

  String isUriLogin() => '$_movieApiUrl/auth/login';

  String isUriRegister() => '$_movieApiUrl/auth/register';

  String isUriListUsers() => '$_movieApiUrl/users';
}
