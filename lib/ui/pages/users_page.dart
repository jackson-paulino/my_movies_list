import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/user_bloc.dart';
import 'package:my_movies_list/data/models/user_model.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            UserCubit(getIt.get<UserRepositoryInferface>())..listUsers(),
        child: const UsersView());
  }
}

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Usuário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserProcessingState) {
              return const Center(child: LoadingCircularProgress());
            }
            if (state is UserFailState) {
              return const Center(
                child: Text('Falha ao carregar os usuários'),
              );
            }

            if (state is UserSuccessState) {
              return Column(
                  children: state.users
                      .map((e) => _buildUsers(context: context, user: e))
                      .toList());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildUsers({required UserModel user, required BuildContext context}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.ratingTitlePage,
          arguments: user.toJson()),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
