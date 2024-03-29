import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;

  const ErrorScreen({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Icon(Icons.error),
            const SizedBox(
              height: 10,
            ),
            Text('Error${message == null ? '' : ': $message'}',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Назад',
                  style: Theme.of(context).textTheme.bodySmall,
                ))
          ],
        ),
      ),
    );
  }
}
