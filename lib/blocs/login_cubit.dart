import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/user_not_found.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';

enum LoginState { initial, processingLogin, loginFailed, userNotFound, success }

class LoginCubit extends Cubit<LoginState> {
  final UserRepositoryInferface _userRepository;

  LoginCubit(this._userRepository) : super(LoginState.initial);

  Future<void> login(String email, String password) async {
    emit(LoginState.processingLogin);
    try {
      await _userRepository.login(email, password);
      emit(LoginState.success);
    } on UserNotFoundException {
      emit(LoginState.userNotFound);
    } on Exception {
      emit(LoginState.loginFailed);
    }
  }
}
