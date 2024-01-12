import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/pages/home/widget/favourites_tab.dart';
import 'package:stp/pages/home/widget/feed_tab.dart';
import 'package:stp/service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthService authService;
  int _currentIndex = 0;
  final feedPage = const FeedTab();
  final favouritesPage = const FavouritesTab();
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    authService = KiwiContainer().resolve<AuthService>();
    _pages.addAll([feedPage, favouritesPage]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: theme.primaryColor,
        title: const Text('Главная'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                authService.logout().then((value) =>
                    Navigator.pushReplacementNamed(context, '/login'));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text(
                    'Выйти из аккаунта',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Избранное',
          ),
        ],
      ),
    );
  }
}
