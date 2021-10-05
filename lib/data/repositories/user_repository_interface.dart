import 'package:my_movies_list/data/models/user_model.dart';

abstract class UserRepositoryInferface {
  Future<UserModel?> login(String email, String password);

  Future<UserModel?> getUser();

  Future<UserModel?> register(String emial, String password, String name);

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<bool> isLogged();

  Future<void> clearSession();
}
