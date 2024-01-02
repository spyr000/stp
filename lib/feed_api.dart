import 'package:flutter/material.dart';
import 'package:stp/feed/page/page_item.dart';
import 'package:dio/dio.dart';
import '../data/service/api_service.dart';
import '../data/mapper/page_mapper.dart';

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
  final List<PageItem> items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    apiService = ApiService(dio);
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
      // User has reached the end of the list
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    try {
      final response = await apiService.fetchData();
      // print(response);
      final fetchedItems = PageMapper.fromResponseModelDto(response);
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
        title: Text('Scroll and Fill'),
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
