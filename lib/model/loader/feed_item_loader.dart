import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/data/mapper/article_item_mapper.dart';
import 'package:stp/pages/home/widget/article_item.dart';
import 'package:stp/service/api_service.dart';

class FeedItemLoader extends ChangeNotifier {
  final ApiService _apiService = KiwiContainer().resolve<ApiService>();
  bool _isLoading = false;
  final List<ArticleItem> feedItems = [];
  final ScrollController scrollController = ScrollController();

  FeedItemLoader() {
    scrollController.addListener(_scrollListener);
    _loadMoreFeedItems();
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreFeedItems();
    }
    if (scrollController.position.maxScrollExtent < 0.0) {
      refreshFeedItems();
    }
  }

  Future<void> _loadMoreFeedItems() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      final response = await _apiService.fetchFeedData();
      log('fetched response: $response');
      final fetchedItems = ArticleItemMapper.fromResponseModelDto(response);
      feedItems.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshFeedItems() async {
    log('refreshing');
    if (_isLoading) return;

    try {
      _isLoading = true;
      final response = await _apiService.fetchFeedData();
      log('refreshed response: $response');
      final refreshedItems = ArticleItemMapper.fromResponseModelDto(response);
      feedItems.clear();
      feedItems.addAll(refreshedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }
}
