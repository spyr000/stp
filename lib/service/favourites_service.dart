import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/exception/add_to_favourites_exception.dart';

import 'auth_service.dart';

class FavouritesService {
  static const int FAVOURITE_BATCH_SIZE = 10;
  static final _firestore = FirebaseFirestore.instance;
  static final _authService = KiwiContainer().resolve<AuthService>();
  static bool isFavouritesRemain = true;

  static Future<void> saveToFavourites(int pageId) async {
    var uid = await _authService.getAuthUserUID();
    if (uid == null) {
      throw AddToFavouritesException(
        code: 'unauthorized',
        message:
            'Пожалуйста войдите в свой аккаунт для выполнения этого действия',
      );
    }

    var existingDoc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .where('pageId', isEqualTo: pageId)
        .get();

    if (existingDoc.docs.isNotEmpty) {
      throw AddToFavouritesException(
        code: 'already-exists',
        message: 'Статья уже находится в вашем избранном',
      );
    }

    await _firestore.collection('users').doc(uid).collection('favourites').add({
      'user_uid': uid,
      'pageId': pageId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<FavouritesBatch> getFavouritesBatch(
      Timestamp? lastFavouriteTimestamp) async {
    var uid = _authService.currentUser;
    if (uid == null) {
      throw AddToFavouritesException(
        code: 'unauthorized',
        message:
            'Пожалуйста войдите в свой аккаунт для выполнения этого действия',
      );
    }

    Query query = _firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .orderBy('timestamp');
    if (lastFavouriteTimestamp != null) {
      query = query.where('timestamp', isGreaterThan: lastFavouriteTimestamp);
    }
    var querySnapshot = await query.limit(FAVOURITE_BATCH_SIZE).get();

    var pageIds =
        querySnapshot.docs.map((doc) => doc['pageId'] as int).toList();

    try {
      var lastItemTimestamp =
          querySnapshot.docs.last.get('timestamp') as Timestamp;
      return FavouritesBatch(
        pageIds: pageIds,
        lastItemTimestamp: lastItemTimestamp,
      );
    } catch (e) {
      return const FavouritesBatch(
        pageIds: [],
        lastItemTimestamp: null,
      );
    }
  }

  static Future<void> deleteById(int pageId) async {
    var uid = await _authService.getAuthUserUID();
    if (uid == null) {
      throw AddToFavouritesException(
        code: 'unauthorized',
        message:
            'Пожалуйста войдите в свой аккаунт для выполнения этого действия',
      );
    }

    var querySnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .where('pageId', isEqualTo: pageId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .doc(querySnapshot.docs.first.id)
          .delete();
    }
  }

  static Future<bool> isInFavourites(int pageId) async {
    var uid = _authService.currentUser;
    if (uid == null) {
      throw AddToFavouritesException(
        code: 'unauthorized',
        message:
            'Пожалуйста войдите в свой аккаунт для выполнения этого действия',
      );
    }

    var querySnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .where('pageId', isEqualTo: pageId)
        .get();

    return querySnapshot.docs.isNotEmpty && querySnapshot.docs.first.exists;
  }
}

class FavouritesBatch {
  final List<int> pageIds;
  final Timestamp? lastItemTimestamp;

  const FavouritesBatch({
    required this.pageIds,
    required this.lastItemTimestamp,
  });

  @override
  String toString() {
    return 'FavouritesBatchResponse{'
        'pageIds: $pageIds,'
        'favouritesCount: $lastItemTimestamp'
        '}';
  }
}
