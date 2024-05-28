import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turfnest_admin/constants.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;



  Stream<User?> get getAuthChange => auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      ShowLoaderDialog(context);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      UserCredential usercredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String Uid = usercredential.user!.uid;
      await prefs.setString('userid', Uid);
      await prefs.setString('email', email);

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showmessage(e.code.toString());
      return false;
    }
  }

  Future<bool> signup(
    
    BuildContext context,
    String name,
    String email,
    String location,
    String password,
  ) async {
    try {
      ShowLoaderDialog(context);
      UserCredential usercredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String Uid = usercredential.user!.uid;

      await prefs.setString('userid', Uid);
      await prefs.setString('email', email);

      await store.collection("admin").doc(Uid).set({
        "id": Uid,
        "name":name,
        "email": email,
        "location":location,
      });
      
      
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showmessage(e.code.toString());
      return false;
    }
  }

   signout() async {
    await auth.signOut();
  }

  Future<bool> changePassword(String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);

        showmessage("Password changed successfully");
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          showmessage(
              'The user must re-authenticate before this operation can be executed.');
        } else {
          showmessage(
              'An error occurred while changing the password: ${e.code}');
        }
      } catch (e) {
        print('An error occurred while changing the password: $e');
      }
    } else {
      showmessage("No user is currently signed in.");
      return false;
    }
    return false;
  }
}
