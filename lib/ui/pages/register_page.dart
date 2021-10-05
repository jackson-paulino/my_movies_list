import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_list/blocs/regsiter_cubit.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';
import 'package:my_movies_list/ui/shared/app_validators.dart';
import 'package:my_movies_list/ui/widgets/custom_button_elevated.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      
      create: (_) => RegisterCubit(getIt.get<UserRepositoryInferface>()),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _textControllerEmail = TextEditingController();
  final _textControllerSenha = TextEditingController();
  final _textControllerConfirmarSenha = TextEditingController();
  final _textControllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state == RegisterState.success) {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Cadastro de login de usuario',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  labelText: 'Nome de usuario',
                  hintText: 'Digite seu nome',
                  controller: _textControllerName,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => AppValidators.validaNome(value!),
                ),
                const SizedBox(height: 12),
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
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  labelText: 'Confirmação de senha',
                  hintText: 'Confirme sua senha',
                  controller: _textControllerConfirmarSenha,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => AppValidators.validarConfirmaSenha(
                      _textControllerSenha.text,
                      _textControllerConfirmarSenha.text),
                ),
                const SizedBox(height: 12),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CustomButtonElevated(
                      text: 'Cadastrar',
                      loading: state == RegisterState.processing,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().register(
                              _textControllerName.text,
                              _textControllerEmail.text,
                              _textControllerSenha.text);
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return Visibility(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(state == RegisterState.userAlreadyExists
                                ? 'Email já está em uso'
                                : 'Falha ao realizar cadastro')));
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
