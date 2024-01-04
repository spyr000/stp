import 'package:flutter/material.dart';
import 'package:stp/feed/page/page_item.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/feed/page/shimmer.dart';
import 'package:stp/ioc/di_container.dart';
import '../service/api_service.dart';
import '../data/mapper/page_item_mapper.dart';
import 'data/mapper/page_card_mapper.dart';

void main() {
  setupContainer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                            children: [
                              ShimmerImage(),
                              CircularProgressIndicator()
                            ],
                          )
                      ),
                  );
                } else if (snapshot.hasError) {
                  return Center( //TODO: ERROR WIDGET
                      child: Text('Error: ${snapshot.error}')
                  );
                } else {
                  var fetchedItems =
                      snapshot.data as List; // Adjust the type accordingly
                  return fetchedItems.isNotEmpty
                      ? fetchedItems[0]
                      : Container();
                }
              },
            );
          });
        }
        return MaterialPageRoute(builder: (context) => HomePage());
      },
      home: HomePage(),
    );
  }

  Future<List> fetchPageData(int pageId) async {
    var apiService = KiwiContainer().resolve<ApiService>();
    final response = await apiService.fetchSinglePageData(pageId);
    debugPrint('fetched response: $response');
    return PageCardMapper.fromResponseModelDto(response);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiService apiService;
  final List<PageItem> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiService = KiwiContainer().resolve<ApiService>();
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
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
