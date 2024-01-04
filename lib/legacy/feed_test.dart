import 'package:flutter/material.dart';
import 'package:stp/feed/page/page_item.dart';

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
  List<PageItem> items = [
    // PageItem(
    //   imageUrl:
    //       "https://pngimg.com/uploads/wikipedia/wikipedia_PNG22.png",
    //   title: "Falcon 1",
    //   description: "safsaffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
    //   pageUrl: "0",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "1",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "2",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "3",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "4",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "5",
    // ),
    // PageItem(
    //   imageUrl:
    //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
    //   title: "Falcon 1",
    //   description: "desc",
    //   pageUrl: "6",
    // )
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    // Simulate loading more items
    // List<String> newItems = List.generate(10, (index) => "New Item ${items.length + index}");
    // setState(() {
    //   items.addAll(newItems);
    // });
    List<PageItem> newItems = [
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "0",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "1",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "2",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "3",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "4",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "5",
      // ),
      // PageItem(
      //   imageUrl:
      //   "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      //   title: "Falcon 1",
      //   description: "desc",
      //   pageUrl: "6",
      // )
    ];
    setState(() {
      items.addAll(newItems);
    });
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
