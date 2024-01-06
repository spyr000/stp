import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/auth/auth_service.dart';
import 'package:stp/data/dto/response_dto.dart';
import 'package:stp/feed/page/loading_screen.dart';
import 'package:stp/feed_api.dart';
import 'package:stp/service/api_service.dart';

import 'auth/registration_screen.dart';
import 'data/mapper/page_card_mapper.dart';
import 'feed/page/error_screen.dart';
import 'feed/page/shimmer.dart';
import 'auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'ioc/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupContainer();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

/// State is persistent and not rebuilt, therefore [Future] is only created once.
/// If [StatelessWidget] is used, in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and makes our app re-enter the
/// loading state, which is undesired.
class _AppState extends State<App> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _authService = KiwiContainer().resolve<AuthService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _initFirebaseSdk,
            builder: (_, snapshot) {
              if (snapshot.hasError) return const ErrorScreen();

              if (snapshot.connectionState == ConnectionState.done) {
                // Assign listener after the SDK is initialized successfully
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    _navigatorKey.currentState!.pushReplacementNamed('/login');
                  }
                  _authService.getAuthUserUID().then((authUserUID) => {
                        if (authUserUID != null)
                          {
                            _navigatorKey.currentState!
                                .pushReplacementNamed('/home')
                          }
                        else
                          {
                            _navigatorKey.currentState!
                                .pushReplacementNamed('/login')
                          }
                      },
                      onError: (error, stackTrace) => _navigatorKey.currentState!
                          .pushReplacementNamed('/login'));

                  // _navigatorKey.currentState!.pushReplacementNamed('/home');
                });
              }

              return const LoadingScreen();
            }),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginScreen(),
          '/page': (context) => const HomePage(),
          '/registration': (context) => const RegistrationScreen(),
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
                    return const LoadingScreen();
                  } else if (snapshot.hasError) {
                    return ErrorScreen(message: snapshot.error?.toString());
                  } else {
                    var fetchedItems = snapshot.data as List;
                    return fetchedItems.isNotEmpty
                        ? fetchedItems[0]
                        : const ErrorScreen(message: 'Page is not found');
                  }
                },
              );
            });
          }
          return MaterialPageRoute(builder: (context) => const HomePage());
        });
  }

  Future<List> fetchPageData(int pageId) async {
    var apiService = KiwiContainer().resolve<ApiService>();
    final ResponseModel response = await apiService.fetchSinglePageData(pageId);
    debugPrint('fetched response: $response');
    return PageCardMapper.fromResponseModelDto(response);
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = KiwiContainer().resolve<AuthService>();
//     return MaterialApp(
//       title: 'Authentication App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => FutureBuilder(
//               future: authService.isAuthenticated(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return snapshot.data == true
//                       ? const HomePage()
//                       : LoginScreen();
//                 } else {
//                   //TODO: LOADING WIDGET
//                   return const CircularProgressIndicator();
//                 }
//               },
//             ),
//         '/home': (context) => const HomePage(),
//         '/login': (context) => LoginScreen(),
//         '/page': (context) => const HomePage(),
//         '/registration': (context) => RegistrationScreen(),
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name!.startsWith('/page')) {
//           return MaterialPageRoute(builder: (context) {
//             final Map<String, dynamic>? args =
//                 settings.arguments as Map<String, dynamic>?;
//
//             int pageId = args?['pageId'] ?? 0;
//
//             return FutureBuilder(
//               future: fetchPageData(pageId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const LoadingScreen();
//                 } else if (snapshot.hasError) {
//                   return ErrorScreen(message: snapshot.error?.toString());
//                 } else {
//                   var fetchedItems = snapshot.data as List;
//                   return fetchedItems.isNotEmpty
//                       ? fetchedItems[0]
//                       : const ErrorScreen(message: 'Page is not found');
//                 }
//               },
//             );
//           });
//         }
//         return MaterialPageRoute(builder: (context) => const HomePage());
//       },
//       // home: HomePage(),
//     );
//   }

//   Future<List> fetchPageData(int pageId) async {
//     var apiService = KiwiContainer().resolve<ApiService>();
//     final ResponseModel response = await apiService.fetchSinglePageData(pageId);
//     debugPrint('fetched response: $response');
//     return PageCardMapper.fromResponseModelDto(response);
//   }
// }
