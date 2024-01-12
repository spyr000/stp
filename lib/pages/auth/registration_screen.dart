import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/service/auth_service.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final AuthService authService = KiwiContainer().resolve<AuthService>();
    const spacer = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
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
                    .register(emailController.text, passwordController.text)
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
              child: const Text('Зарегистрироваться'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('У вас уже есть аккаунт? Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
