import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Fluttertoast.showToast(
        msg: 'Successfully Sign In.',
      );

      notifyListeners();
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(
      msg: 'Successfully Logout.',
      backgroundColor: Colors.grey[800],
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
    );
  }
}
