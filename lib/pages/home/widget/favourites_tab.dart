import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stp/pages/home/loader/favourites_item_loader.dart';


class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavouritesItemLoader(),
      child: Consumer<FavouritesItemLoader>(
        builder: (context, loader, _) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: loader.refreshFavouriteItems,
              child: ListView.builder(
                controller: loader.scrollController,
                itemCount: loader.favouriteItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: loader.favouriteItems[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
