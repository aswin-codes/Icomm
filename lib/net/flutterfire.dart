import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> signIn(String email, String password) async {
  try {
    UserCredential res = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    //Storing user details in the local storage using shared preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    String? userName = res.user?.displayName;
    await prefs.setString("userName", userName ?? "Anon");
    await prefs.setBool("isUserLoggedIn", true);
    print(res);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<dynamic> register(String email, String password,String userName) async {
  try {
    UserCredential res = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(userName);

    //Storing user details in the local storage using shared preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("userName", userName);
    await prefs.setBool("isUserLoggedIn", true);
    print(res);
    print(user);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provide is too weak");
    } else if (e.code == 'email-already-in-use') {
      print("The account already exists for that email");
    }
    return e.code;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
