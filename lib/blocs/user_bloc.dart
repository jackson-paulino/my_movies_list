import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/data/models/user_model.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';

abstract class UserState {}

class UserProcessingState extends UserState {}

class UserSuccessState extends UserState {
  List<UserModel> users;

  UserSuccessState(this.users);

  List<UserModel> get props => users;
}

class UserFailState extends UserState {}

class UserCubit extends Cubit<UserState> {
  final UserRepositoryInferface _userRepository;
  UserCubit(this._userRepository) : super(UserProcessingState());

  Future<void> listUsers() async {
    try {
      var response = await _userRepository.getlistUsers();
      emit(UserSuccessState(response));
    } catch (e) {
      emit(UserFailState());
    }
  }
}
