import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../service/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    apiService = ApiService(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrofit Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final response = await apiService.fetchFeedData();
              // Process the response here
              print(response);
            } catch (e) {
              print('Error: $e');
            }
          },
          child: Text('Fetch Data'),
        ),
      ),
    );
  }
}