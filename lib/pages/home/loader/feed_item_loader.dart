import 'package:flutter/cupertino.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/data/mapper/article_item_mapper.dart';
import 'package:stp/pages/home/widget/article_item.dart';
import 'package:stp/service/api_service.dart';

class FeedItemLoader extends ChangeNotifier {
  final List<ArticleItem> feedItems = [];
  final ScrollController scrollController = ScrollController();
  final ApiService apiService = KiwiContainer().resolve<ApiService>();

  bool isLoading = false;

  FeedItemLoader() {
    scrollController.addListener(_scrollListener);
    loadMoreFeedItems();
  }

  void _scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreFeedItems();
    }
  }

  Future<void> loadMoreFeedItems() async {
    if (isLoading) return;

    try {
      isLoading = true;
      final response = await apiService.fetchFeedData();
      debugPrint('fetched response: $response');
      final fetchedItems = ArticleItemMapper.fromResponseModelDto(response);
      feedItems.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> refreshFeedItems() async {
    try {
      final response = await apiService.fetchFeedData();
      debugPrint('refreshed response: $response');
      final refreshedItems = ArticleItemMapper.fromResponseModelDto(response);
      feedItems.clear();
      feedItems.addAll(refreshedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
