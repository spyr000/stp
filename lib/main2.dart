import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/data/dto/response_dto.dart';
import 'package:stp/feed_api.dart';
import 'package:stp/service/api_service.dart';

import 'auth/registration_screen.dart';
import 'data/mapper/page_card_mapper.dart';
import 'feed/page/shimmer.dart';
import 'home_screen.dart';
import 'auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ioc/di_container.dart';

void main() {
  setupContainer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: checkAuthentication(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {

                  return snapshot.data == true ? HomePage() : LoginScreen();
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginScreen(),
        '/page': (context) => const HomePage(),
        '/registration': (context) => RegistrationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/page')) {
          return MaterialPageRoute(builder: (context) {
            final Map<String, dynamic>? args =
                settings.arguments as Map<String, dynamic>?;

            int pageId = args?['pageId'] ?? 0;

            return FutureBuilder(
              future: fetchPageData(pageId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [ShimmerImage(), CircularProgressIndicator()],
                    )),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      //TODO: ERROR WIDGET
                      child: Text('Error: ${snapshot.error}'));
                } else {
                  var fetchedItems =
                      snapshot.data as List;
                  return fetchedItems.isNotEmpty
                      ? fetchedItems[0]
                      : Container(); //TODO: ERROR WIDGET
                }
              },
            );
          });
        }
        return MaterialPageRoute(builder: (context) => HomePage());
      },
      // home: HomePage(),
    );
  }

  Future<List> fetchPageData(int pageId) async {
    var apiService = KiwiContainer().resolve<ApiService>();
    final ResponseModel response = await apiService.fetchSinglePageData(pageId);
    debugPrint('fetched response: $response');
    return PageCardMapper.fromResponseModelDto(response);
  }

  Future<bool> checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('authenticated');
  }
}


