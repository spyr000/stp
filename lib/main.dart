import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/pages/auth/login_screen.dart';
import 'package:stp/pages/auth/registration_screen.dart';
import 'package:stp/service/auth_service.dart';
import 'package:stp/data/dto/response_dto.dart';
import 'package:stp/pages/util/loading_screen.dart';
import 'package:stp/pages/home/home_page.dart';
import 'package:stp/service/api_service.dart';

import 'package:stp/data/mapper/article_card_mapper.dart';
import 'package:stp/pages/util/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stp/firebase_options.dart';
import 'package:stp/service/ioc/di_container.dart';
import 'package:stp/pages/onboarding/onboarding_page.dart';

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
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
            ),
          ),
          primarySwatch: Colors.deepOrange,
        ),
        home: FutureBuilder(
          future: _initFirebaseSdk,
          builder: (_, firebaseLoadingSnapshot) {
            if (firebaseLoadingSnapshot.hasError) return const ErrorScreen();

            if (firebaseLoadingSnapshot.connectionState ==
                ConnectionState.done) {
              return FutureBuilder<bool>(
                future: _checkOnboardingStatus(),
                builder: (context, onboardingSnapshot) {
                  if (onboardingSnapshot.connectionState ==
                      ConnectionState.done) {
                    if (onboardingSnapshot.data == true) {
                      _navigateToHomeOrLogin();
                    } else {
                      return OnboardingPage();
                    }
                  }
                  return const LoadingScreen();
                },
              );
            }
            return const LoadingScreen();
          },
        ),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginScreen(),
          '/page': (context) => const HomePage(),
          '/registration': (context) => const RegistrationScreen(),
        },
        onGenerateRoute: _navigateToSpecifiedPage);
  }

  Future<List> _fetchPageData(int pageId) async {
    var apiService = KiwiContainer().resolve<ApiService>();
    final ResponseModel response = await apiService.fetchPagesData(pageId);
    debugPrint('fetched response: $response');
    return ArticleCardMapper.fromResponseModelDto(response);
  }

  Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOnboardingComplete') ?? false;
  }

  void _navigateToHomeOrLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _navigatorKey.currentState!.pushReplacementNamed('/login');
      }
      _authService.getAuthUserUID().then(
            (authUserUID) => {
              if (authUserUID != null)
                {_navigatorKey.currentState!.pushReplacementNamed('/home')}
              else
                {_navigatorKey.currentState!.pushReplacementNamed('/login')}
            },
            onError: (error, stackTrace) =>
                _navigatorKey.currentState!.pushReplacementNamed('/login'),
          );
    });
  }

  MaterialPageRoute _navigateToSpecifiedPage(RouteSettings settings) {
    if (settings.name!.startsWith('/page')) {
      return MaterialPageRoute(builder: (context) {
        final Map<String, dynamic>? args =
            settings.arguments as Map<String, dynamic>?;

        int pageId = args?['pageId'] ?? 0;

        return FutureBuilder(
          future: _fetchPageData(pageId),
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
  }
}
