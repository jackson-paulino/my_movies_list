import 'package:flutter/material.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';
import 'package:my_movies_list/ui/widgets/custom_button_elevated.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
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
              const CustomTextField(
                labelText: 'Nome de usuario',
                hintText: 'Digite seu nome',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                labelText: 'Confirmação de senha',
                hintText: 'Confirme sua senha',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 12),
              CustomButtonElevated(
                  text: 'Cadastrar',
                  loading: false,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                  }),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
