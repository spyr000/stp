import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _authService = FirebaseAuth.instance;
  final Codec<String, String> _codec = utf8.fuse(base64);
  final _sharedPrefsKey = 'auth_credentials';

  get currentUser => _authService.currentUser?.uid;

  Future<void> register(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Пожалуйста заполните пустые поля';
      }
      var userCredential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences.getInstance().then((prefs) => {
            prefs.setString(_sharedPrefsKey, _codec.encode('$email:$password'))
          });
      log('credential uid: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Error: $e';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Please fill in the blank fields';
      }
      var userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences.getInstance().then((prefs) => {
            prefs.setString(_sharedPrefsKey, _codec.encode('$email:$password'))
          });
      log('credential uid: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Error: $e';
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getAuthUserUID() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_sharedPrefsKey)) return null;
    var encodedCreds = prefs.getString(_sharedPrefsKey);
    if (encodedCreds == null) return null;
    var creds = _codec.decode(encodedCreds).split(':');
    if (creds.length < 2) return null;
    var email = creds[0];
    var password = creds[1];
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
    return _authService.currentUser?.uid;
  }

  Future<void> logout() async {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.remove(_sharedPrefsKey));
    await FirebaseAuth.instance.signOut();
  }
}
