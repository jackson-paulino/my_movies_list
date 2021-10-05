import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';

enum SplashState { checkingUser, userLoggend, userNotLogged }

class SplashCubit extends Cubit<SplashState> {
  final UserRepositoryInferface _userRepository;
  SplashCubit(this._userRepository) : super(SplashState.checkingUser);

  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLogged = await _userRepository.isLogged();

    if (isLogged) {
      emit(SplashState.userLoggend);
    } else {
      emit(SplashState.userNotLogged);
    }
  }
}
