import 'package:my_movies_list/data/models/user_model.dart';

abstract class UserRepositoryInferface {
  Future<UserModel?> login(String email, String password);

  Future<UserModel?> getUser({bool cadastro = false});

  Future<UserModel?> register(String name, String email, String password);

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<bool> isLogged();

  Future<void> clearSession();

  Future<List<UserModel>> getlistUsers();
}
