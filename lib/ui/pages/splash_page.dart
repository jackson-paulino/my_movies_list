import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/splash_cubit.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_colors.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            SplashCubit(getIt.get<UserRepositoryInferface>())..checkUser(),
        child: const SplashView());
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, state) {
        if (state == SplashState.userLoggend) {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        } else if (state == SplashState.userNotLogged) {
          Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        }
      },
      child: const Scaffold(
        body: Center(
          child: Icon(
            Icons.movie,
            size: 120.0,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
