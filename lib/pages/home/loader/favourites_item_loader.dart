import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/data/mapper/article_item_mapper.dart';
import 'package:stp/pages/home/widget/article_item.dart';
import 'package:stp/service/api_service.dart';
import 'package:stp/service/favourites_service.dart';

class FavouritesItemLoader extends ChangeNotifier {
  final List<ArticleItem> favouriteItems = [];
  final ScrollController scrollController = ScrollController();
  final ApiService apiService = KiwiContainer().resolve<ApiService>();
  Timestamp? lastFavouriteTimestamp;

  bool isLoading = false;

  FavouritesItemLoader() {
    scrollController.addListener(_scrollListener);
    loadMoreFavourites();
  }

  void _scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreFavourites();
    }
  }

  Future<void> loadMoreFavourites() async {
    if (isLoading) return;

    try {
      isLoading = true;
      final favouritesBatch = await FavouritesService.getFavouritesBatch(lastFavouriteTimestamp);
      lastFavouriteTimestamp = favouritesBatch.lastItemTimestamp ?? lastFavouriteTimestamp;

      if (favouritesBatch.pageIds.isEmpty) return;

      final response = await apiService.fetchSpecifiedPagesData(favouritesBatch.pageIds);
      debugPrint('fetched response: $response');
      final fetchedItems = ArticleItemMapper.fromResponseModelDto(response);
      favouriteItems.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<void> refreshFavouriteItems() async {
    try {
      lastFavouriteTimestamp = null;
      final favouritesBatch = await FavouritesService.getFavouritesBatch(lastFavouriteTimestamp);
      lastFavouriteTimestamp = favouritesBatch.lastItemTimestamp ?? lastFavouriteTimestamp;

      if (favouritesBatch.pageIds.isEmpty) return;

      final response = await apiService.fetchSpecifiedPagesData(favouritesBatch.pageIds);
      debugPrint('refreshed response: $response');
      final refreshedItems = ArticleItemMapper.fromResponseModelDto(response);
      favouriteItems.clear();
      favouriteItems.addAll(refreshedItems);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}