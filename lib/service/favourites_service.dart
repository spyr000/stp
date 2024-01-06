import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/exception/add_to_favourites_exception.dart';

import '../auth/auth_service.dart';

class FavouritesService {
  static final _firestore = FirebaseFirestore.instance;
  static final _authService = KiwiContainer().resolve<AuthService>();

  static Future<void> save(int pageId) async {
    var uid = await _authService.getAuthUserUID();
    if (uid == null) {
      throw AddToFavouritesException(
        code: 'unauthorized',
        message: 'Please login to your account for doing this action',
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
        message: 'Page already exists in favorites',
      );
    }

    await _firestore.collection('users').doc(uid).collection('favourites').add({
      'user_uid': uid,
      'pageId': pageId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<List<int>> getFavouritePageIds() async {
    var uid = await _authService.getAuthUserUID();
    if (uid == null) {
      throw 'Unauthorized';
    }

    var querySnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .get();

    var pageIds =
        querySnapshot.docs.map((doc) => doc['pageId'] as int).toList();

    print(pageIds.toString());
    return pageIds;
  }

  static Future<void> delete(int pageId) async {
    var uid = await _authService.getAuthUserUID();
    if (uid == null) {
      throw 'Unauthorized';
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
}
