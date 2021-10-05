import 'package:flutter/material.dart';
import 'package:my_movies_list/ui/shared/app_colors.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';
import 'package:my_movies_list/ui/widgets/custom_button_elevated.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  controller: _textControllerSenha,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 12),
                CustomButtonElevated(
                    text: 'Entrar',
                    loading: false,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homePage);
                    }),
                const SizedBox(height: 20.0),
                _buildCreateAccountLink(context)
              ],
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
