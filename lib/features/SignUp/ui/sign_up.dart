import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/features/SignUp/bloc/sign_up_bloc.dart';
import 'package:icomm/features/SignUp/model/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpBloc signUpBloc = SignUpBloc();

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _fullNameField = TextEditingController();

  bool isShowPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    signUpBloc.add(SignUpInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignInScreenNavigateState) {
          Navigator.pushNamed(context, "/signIn");
        } else if (state is HomeScreenNavigateState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account created successfully")));
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else if (state is WeakPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Very weak password. Try again with strong password")));
        } else if (state is EmailAlreadyInUseErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Email is already is in use. Try login...")));
        } else if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Error: Sorry something went wrong. Try again later")));
        }
      },
      listenWhen: (previous, current) => current is SignUpActionState,
      buildWhen: (previous, current) => current is! SignUpActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignUpInitial:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/handshake.jpg",
                          height: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Sign Up",
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
                              "assets/images/head.png",
                              height: 25,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.roboto(
                                    color: Colors.black, fontSize: 15),
                                controller: _fullNameField,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Your Name",
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
                        height: 50,
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                            onPressed: () {
                              signUpBloc.add(SignUpButtonClicked(
                                  userModel: UserModel(
                                      email: _emailField.text,
                                      password: _passwordField.text,
                                      userName: _fullNameField.text)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Create Account",
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
                          onTap: () => signUpBloc
                              .add(SignInScreenNavigateButtonClicked()),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Already have an account ?   ",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 14,
                                )),
                            TextSpan(
                                text: "Login In",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))
                          ])),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text("Sorry, something went wrong. Try again later"),
              ),
            );
        }
      },
    );
  }
}
