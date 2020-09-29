import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase_db/home_screen.dart';
import 'package:login_firebase_db/login/bloc/login_screen.dart';
import 'package:login_firebase_db/splash_screen.dart';
import 'package:flutter/semantics.dart';
import 'package:login_firebase_db/authentication_bloc/authentication_bloc.dart';
import 'package:login_firebase_db/authentication_bloc/authentication_event.dart';
import 'package:login_firebase_db/authentication_bloc/authentication_state.dart';
import 'package:login_firebase_db/authentication_bloc/simple_bloc_delegate.dart';
import 'package:login_firebase_db/firebase/user_repository.dart';
 main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized){
              return SplashScreen();
            }
            if (state is Unauthenticated){
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated){
              return HomeScreen(name: state.displayName);
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}