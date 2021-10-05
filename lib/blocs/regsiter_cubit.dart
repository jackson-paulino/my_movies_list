import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/exceptions/user_already_exits.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';

enum RegisterState { initial, processing, success, userAlreadyExists, failed }

class RegisterCubit extends Cubit<RegisterState> {
  final UserRepositoryInferface _userRepository;

  RegisterCubit(this._userRepository) : super(RegisterState.initial);

  Future<void> register(String name, String email, String password) async {
    emit(RegisterState.processing);
    try {
      await _userRepository.register(name, email, password);
      emit(RegisterState.success);
    } on UserAlreadyExistsException {
      emit(RegisterState.userAlreadyExists);
    } on Exception {
      emit(RegisterState.failed);
    }
  }
}
