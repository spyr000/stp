import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/service/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthService authService = KiwiContainer().resolve<AuthService>();
    const spacer = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Электронная почта'),
            ),
            spacer,
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            spacer,
            ElevatedButton(
              onPressed: () async {
                await authService
                    .login(emailController.text, passwordController.text)
                    .then(
                        (value) =>
                            Navigator.pushReplacementNamed(context, "/home"),
                        onError: (error, stackTrace) {
                  final snackBar = SnackBar(
                    content: Text(error.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text('Войти'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/registration');
              },
              child: const Text('У вас нет учетной записи? Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
