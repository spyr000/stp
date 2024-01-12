import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stp/model/loader/feed_item_loader.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedItemLoader(),
      child: Consumer<FeedItemLoader>(
        builder: (context, loader, _) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: loader.refreshFeedItems,
              child: ListView.builder(
                controller: loader.scrollController,
                itemCount: loader.feedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: loader.feedItems[index],
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
