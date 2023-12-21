import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/features/SplashScreen/bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    splashScreenBloc.add(SplashScreenInitialEvent());
    super.initState();
  }

  SplashScreenBloc splashScreenBloc = SplashScreenBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is NavigateToSignInScreenState) {
          Navigator.pushNamed(context, '/signIn');
        }
      },
      bloc: splashScreenBloc,
      listenWhen: (previous, current) => current is SplashScreenActionState,
      buildWhen: (previous, current) => current is! SplashScreenActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SplashScreenInitial:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Icomm",
                  style: GoogleFonts.kanit(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                                "assets/images/ecommerce_vector.png")),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Unlock exclusive deals and special offers",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 45,
                              height: 1,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Stay tuned for regular updates and promotions, ensuring you get the best value for your tech investments",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                splashScreenBloc
                                    .add(SignInScreenNavigateEvent());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          default:
            return Scaffold(
              body: Center(
                  child:
                      Text("Sorry something went wrong. Try again Later...")),
            );
        }
      },
    );
  }
}
