import 'package:en_learn/providers/login_form_provider.dart';
import 'package:en_learn/widgets/auth_background.dart';
import 'package:en_learn/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Bienvenido",
                      key: Key('welcome_text'), // Added key for testing
                      style: TextStyle(
                        color: Color.fromRGBO(0, 102, 129, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Ingresa tus datos",
                      key: Key('subtitle_text'), // Added key for testing
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                key: const Key('forgot_password_button'), // Added key for testing
                onPressed: () {
                  print("se presiono olvide contraseña");
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    const Color.fromRGBO(7, 67, 83, 0.9),
                  ),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text(
                  'Olvide mi contraseña',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              key: const Key('email_field'), // Added key for testing
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Jhon@correo.com',
                labelText: 'Correo electronico',
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Ingrese un correo valido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              key: const Key('password_field'), // Added key for testing
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: '**************',
                labelText: 'Password',
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) return null;
                return 'la contraseña debe ser mayor a 6 caracteres';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              key: const Key('login_button'), // Added key for testing
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromRGBO(7, 67, 83, 0.9),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;
                      
                      loginForm.isLoading = true;
                      await Future.delayed(const Duration(seconds: 1));
                      
                      if (!context.mounted) return;
                      Navigator.pushReplacementNamed(context, 'home');
                      loginForm.isLoading = false;
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80, 
                  vertical: 15,
                ),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}