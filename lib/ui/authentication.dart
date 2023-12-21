import 'package:flutter/material.dart';
import 'package:icomm/net/flutterfire.dart';
import 'package:icomm/ui/home_view.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.blueAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: _emailField,
              decoration: const InputDecoration(
                  hintText: "example@gmai.com",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordField,
              decoration: const InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    //Navigate to HomeScreen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  } else {}
                },
                child: Text("Register"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await signIn(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    //Navigate to HomeScreen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  } else {}
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
