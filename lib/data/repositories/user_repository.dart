import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_movies_list/data/exceptions/user_already_exits.dart';
import 'package:my_movies_list/data/exceptions/user_not_found.dart';
import 'package:my_movies_list/data/models/user_model.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';
import 'package:my_movies_list/ui/shared/app_url.dart';

class UserRepository implements UserRepositoryInferface {
  final HttpService _httpService;
  final _secureStorage = const FlutterSecureStorage();
  final AppUri _appUri = AppUri();
  UserModel? user;

  UserRepository(this._httpService);

  @override
  Future<String?> getToken() {
    return _secureStorage.read(key: 'AUTH_TOKEN');
  }

  @override
  Future<UserModel?> getUser({bool cadastro = false}) async {
    if (user == null) {
      final token = await getToken();
      final headers = {'Authorization': 'Bearer $token'};
      final response =
          await _httpService.getRequest(_appUri.isUriUser(), headers: headers);
      user = UserModel.fromJson(response.content!);
    }
    return user;
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    final response = await _httpService.postRequest(_appUri.isUriLogin(), body);

    if (response.success) {
      var token = response.content!['token'];

      await saveToken(token);

      return getUser();
    }

    if (response.statusCode == 400) {
      throw UserNotFoundException();
    }

    throw Exception('Falha ao realizar login');
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

  @override
  Future<UserModel?> register(
      String name, String email, String password) async {
    final body = {'email': email, 'password': password, 'name': name};
    var response =
        await _httpService.postRequest(_appUri.isUriRegister(), body);

    if (response.success) {
      var token = response.content!['token'];

      await saveToken(token);

      return getUser(cadastro: true);
    }

    if (response.statusCode == 400) {
      throw UserAlreadyExistsException();
    }

    throw Exception('Falha cadastrar usu??rio');
  }

  @override
  Future<List<UserModel>> getlistUsers() async {
    final token = await getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _httpService.getRequest(_appUri.isUriListUsers(),
        headers: headers);

    if (response.success) {
      List<dynamic> data = response.content!['data'];
      return List<UserModel>.from(data.map((json) => UserModel.fromJson(json)));
    }

    return [];
  }
}
