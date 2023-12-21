import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icomm/features/SignIn/bloc/sign_in_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      },
      bloc: signInBloc,
      listenWhen: (previous, current) => current is SignInActionState,
      buildWhen: (previous, current) => current is! SignInActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignInInitial:
            return Scaffold(
              appBar: AppBar(
                title: Text("Sign In"),
              ),
              body: Center(child: Text("Hi")),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
