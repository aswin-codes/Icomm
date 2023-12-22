import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/features/SignIn/bloc/sign_in_bloc.dart';
import 'package:icomm/features/SignIn/model/user_credential_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  bool isShowPassword = false;

  @override
  void initState() {
    signInBloc.add(SignInInitialEvent());
    super.initState();
  }

  final SignInBloc signInBloc = SignInBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is NavigateToSignUpScreenState) {
          Navigator.pushNamed(context, "/signUp");
        } else if (state is NavigateToHomeScreenState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login Successful")));
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else if (state is SignInLoadingState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Loading...")));
        } else if (state is SignInErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Error : Incorrect email and password. Try Again...")));
        }
      },
      bloc: signInBloc,
      listenWhen: (previous, current) => current is SignInActionState,
      buildWhen: (previous, current) => current is! SignInActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignInInitial:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Image.asset("assets/images/delivery.jpg",
                            height: 250,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Sign In",
                          style: GoogleFonts.kanit(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 35),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/images/email_sign.png",
                                height: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 15),
                                  controller: _emailField,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      hintText: "example@gmail.com",
                                      hintStyle: GoogleFonts.roboto(
                                          color: Colors.grey, fontSize: 15)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/images/lock.png",
                                height: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 15),
                                  obscureText: !isShowPassword,
                                  controller: _passwordField,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(top: 15),
                                      hintText: "your-password",
                                      hintStyle: GoogleFonts.roboto(
                                          color: Colors.grey, fontSize: 15),
                                      suffixIcon: isShowPassword
                                          ? GestureDetector(
                                              child: const Icon(
                                                Icons.visibility_outlined,
                                                color: Colors.grey,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  isShowPassword =
                                                      !isShowPassword;
                                                });
                                              },
                                            )
                                          : GestureDetector(
                                              child: const Icon(
                                                Icons.visibility_off_outlined,
                                                color: Colors.grey,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  isShowPassword =
                                                      !isShowPassword;
                                                });
                                              },
                                            )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: MaterialButton(
                              onPressed: () {
                                signInBloc.add(SignInButtonClickedEvent(
                                    userCredential: UserCredential(
                                        email: _emailField.text,
                                        password: _passwordField.text)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () =>
                                signInBloc.add(SignUpNavigateButtonClicked()),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "New to Icomm ?   ",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                  )),
                              TextSpan(
                                  text: "Create Account",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600))
                            ])),
                          ),
                        )
                      ],
                    )),
              )),
            );
          default:
            return const Scaffold(
              body: Center(
                  child: Text(
                      "Sorry, something went wrong. Please try again later")),
            );
        }
      },
    );
  }
}
