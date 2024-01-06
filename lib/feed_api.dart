import 'package:flutter/material.dart';
import 'package:stp/auth/auth_service.dart';
import 'package:stp/feed/page/page_item.dart';
import 'package:kiwi/kiwi.dart';
import '../service/api_service.dart';
import '../data/mapper/page_item_mapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthService authService;
  late ApiService apiService;
  final List<PageItem> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiService = KiwiContainer().resolve<ApiService>();
    authService = KiwiContainer().resolve<AuthService>();
    _scrollController.addListener(_scrollListener);
    _loadMoreItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    try {
      final response = await apiService.fetchFeedData();
      debugPrint('fetched response: $response');
      final fetchedItems = PageItemMapper.fromResponseModelDto(response);
      setState(() {
        items.addAll(fetchedItems);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: items[index],
          );
        },
      ),
    );
  }
}
