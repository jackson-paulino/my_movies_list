import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_movies_list/data/exceptions/user_already_exits.dart';
import 'package:my_movies_list/data/exceptions/user_not_found.dart';
import 'package:my_movies_list/data/models/user_model.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';
import 'package:my_movies_list/ui/shared/app_string.dart';

class UserRepository implements UserRepositoryInferface {
  final HttpService _http;
  final _secureStorage = const FlutterSecureStorage();
  final _baseUrl = Strings.movieApiUrl;
  UserModel? user;

  UserRepository(this._http);

  @override
  Future<String?> getToken() {
    return _secureStorage.read(key: 'AUTH_TOKEN');
  }

  @override
  Future<UserModel?> getUser() async {
    if (user == null) {
      final token = await getToken();
      final uri = '$_baseUrl/auth/me';
      final headers = {'Authorization': 'Bearer $token'};
      final response = await _http.getRequest(uri, headers: headers);
      user = UserModel.frojson(response.content!);
    }
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    final url = '$_baseUrl/auth/login';
    final body = {'email': email, 'password': password};
    final response = await _http.postRequest(url, body);

    if (response.success) {
      var token = response.content!['token'];

      await saveToken(token);
      await getUser();
    }

    if (response.statusCode == 400) {
      throw UserNotFoundException();
    }

    throw Exception('Falha ao realizar login');
  }

  @override
  Future<UserModel?> register(
      String email, String password, String name) async {
    final url = '$_baseUrl/auth/regsiter';
    final body = {'email': email, 'password': password, 'name': name};

    var response = await _http.postRequest(url, body);

    if (response.success) {
      var token = response.content!['token'];

      await saveToken(token);

      return getUser();
    }

    if (response.statusCode == 400) {
      throw UserAlreadyExistsException();
    }

    throw Exception('Falha cadastrar usuário');
  }

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'AUTH_TOKEN', value: token);
  }

  @override
  Future<bool> isLogged() async {
    final token = await getToken();
    return token != null;
  }

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: 'AUTH_TOKEN');
  }
}
