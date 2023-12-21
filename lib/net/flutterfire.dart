import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    UserCredential res = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(res);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    UserCredential res = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName("Aswin Raaj");

    print(res);
    print(user);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provide is too weak");
    } else if (e.code == 'email-already-in-use') {
      print("The account already exists for that email");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
