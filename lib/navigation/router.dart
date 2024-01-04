import 'package:flutter/material.dart';
import 'package:stp/data/mapper/page_card_mapper.dart';
import 'package:stp/feed_api.dart';
import '../service/api_service.dart';

class PageRouter {
  final ApiService apiService;

  PageRouter({required this.apiService});

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name!.startsWith('/page')) {
      // Extract the title parameter from the route
      final Map<String, dynamic>? args =
      settings.arguments as Map<String, dynamic>?;

      // Pass the extracted title to the PageCard widget
      return MaterialPageRoute(builder: (context) {
        int pageId = args?['pageId'] ?? 0;
        var fetchedItems = [];
        apiService.fetchSinglePageData(pageId).then((final response) {
          debugPrint('fetched response: $response');
          fetchedItems = PageCardMapper.fromResponseModelDto(response);
        });
        return fetchedItems[0];
      });
    }
    return MaterialPageRoute(builder: (context) => HomePage());
  }
}