import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/login_cubit.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_colors.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';
import 'package:my_movies_list/ui/shared/app_validators.dart';
import 'package:my_movies_list/ui/widgets/custom_button_elevated.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginCubit(getIt.get<UserRepositoryInferface>()),
        child: LoginView());
  }
}

class LoginView extends StatelessWidget {
  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerSenha = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, state) {
        if (state == LoginState.success) {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Informe suas credencias para começar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    labelText: 'E-mail',
                    hintText: 'Digite seu e-mail',
                    controller: _textControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => AppValidators.validarEmail(value!),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    controller: _textControllerSenha,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => AppValidators.validarSenha(value!),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return CustomButtonElevated(
                        text: 'Entrar',
                        loading: state == LoginState.processingLogin,
                        onPressed: () {
                          context.read<LoginCubit>().login(
                              _textControllerEmail.text,
                              _textControllerSenha.text);
                        },
                      );
                    },
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                    return Visibility(
                      visible: state == LoginState.loginFailed ||
                          state == LoginState.userNotFound,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            state == LoginState.userNotFound
                                ? 'Usuário não encontrado'
                                : 'Falha no login',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20.0),
                  _buildCreateAccountLink(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não tem uma conta?',
          style: TextStyle(color: AppColors.darkGrey),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.registerUserPage),
          child: const Text('Criar minha conta'),
        ),
      ],
    );
  }
}
