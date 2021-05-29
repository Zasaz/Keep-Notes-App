import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keep_notes/Services/error_handler.dart';
import 'package:keep_notes/ui/HomeScreen/home_screen.dart';
import 'package:keep_notes/ui/LoginScreen/login_screen.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

// ignore: missing_return
Future<bool> signInWithGoogle(BuildContext context) async {
  try {
    // googleSignIn.disconnect();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);

      final User user = userCredential.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photo': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
        'role': 'user'
      };

      //  Check weather user is new or old
      users.doc(user.uid).get().then((doc) {
        if (doc.exists) {
          doc.reference.update(userData);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          users.doc(user.uid).set(userData);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });

    }
  } catch (e) {
    ErrorHandler().errorDialog(context, e);
  }
}

class GoogleImageServices {
  getProfileImage() {
    if (firebaseAuth.currentUser.photoURL != null) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.network(
            firebaseAuth.currentUser.photoURL,
            width: 35,
            height: 35,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      Icon(Icons.account_circle_sharp, size: 20);
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    return LoginPage();
  }
}

class CheckIfUserIsSignedIn {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else
          return LoginPage();
      },
    );
  }
}
