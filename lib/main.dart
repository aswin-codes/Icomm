import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icomm/features/SignIn/ui/sign_in.dart';
import 'package:icomm/features/SplashScreen/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icomm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        "/splash" : (BuildContext context) => SplashScreen(),
        '/signIn' : (BuildContext context) => SignIn()
      },
      initialRoute: "/splash",
    );
  }
}
