import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  signUp(String email, String password, context) async {
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading...'),
              ],
            ),
          );
        },
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      print("_signUp() - user: $user");

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.pop(context);
      showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Message"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('user created and we send a email verification'),
              ],
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('An account already exists for that email.')));
      } else {
        print(e.message);
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print(user);

      if (user == null) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      await user?.reload();
      user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        print("user hasn't verified email");
        return false;
      } else {
        print("user HAS verified email & is signed in");
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for thatail.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      } else {
        print("An error occurred: \"${e.message}\"");
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
