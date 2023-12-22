import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/features/Start/bloc/start_bloc.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StartBloc startBloc = StartBloc();

  @override
  void initState() {
    // TODO: implement initState
    startBloc.add(StartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartBloc, StartState>(
      bloc: startBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeScreenNavigateState) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else if (state is SplashScreenNavigateState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/splash', (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(
              "Icomm",
              style: GoogleFonts.kanit(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25),
            ),
          ),
        );
      },
    );
  }
}
