import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/data/mapper/article_item_mapper.dart';
import 'package:stp/pages/home/widget/article_item.dart';
import 'package:stp/service/api_service.dart';
import 'package:stp/service/favourites_service.dart';

class FavouritesItemLoader extends ChangeNotifier {
  final List<ArticleItem> favouriteItems = [];
  final ScrollController scrollController = ScrollController();
  final ApiService _apiService = KiwiContainer().resolve<ApiService>();
  Timestamp? _lastFavouriteTimestamp;
  bool _isLoading = false;

  FavouritesItemLoader() {
    scrollController.addListener(_scrollListener);
    _loadMoreFavourites();
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreFavourites();
    }
    if (scrollController.position.maxScrollExtent < 0.0) {
      refreshFavouriteItems();
    }
  }

  Future<void> _loadMoreFavourites() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      final favouritesBatch =
          await FavouritesService.getFavouritesBatch(_lastFavouriteTimestamp);
      _lastFavouriteTimestamp =
          favouritesBatch.lastItemTimestamp ?? _lastFavouriteTimestamp;

      if (favouritesBatch.pageIds.isEmpty) return;

      final response =
          await _apiService.fetchSpecifiedPagesData(favouritesBatch.pageIds);
      log('fetched response: $response');
      final fetchedItems = ArticleItemMapper.fromResponseModelDto(response);
      favouriteItems.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshFavouriteItems() async {
    log('refreshing');
    try {
      _lastFavouriteTimestamp = null;
      final favouritesBatch =
          await FavouritesService.getFavouritesBatch(_lastFavouriteTimestamp);
      _lastFavouriteTimestamp =
          favouritesBatch.lastItemTimestamp ?? _lastFavouriteTimestamp;

      if (favouritesBatch.pageIds.isEmpty) return;
      final response =
          await _apiService.fetchSpecifiedPagesData(favouritesBatch.pageIds);
      log('refreshed response: $response');
      final refreshedItems = ArticleItemMapper.fromResponseModelDto(response);

      favouriteItems.clear();
      favouriteItems.addAll(refreshedItems);
    } catch (e) {
      rethrow;
    }
  }
}
