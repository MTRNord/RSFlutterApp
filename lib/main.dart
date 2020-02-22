import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/AuthenticationBloc.dart';
import 'blocs/MapBloc.dart';
import 'components/LoadingIndicator.dart';
import 'events/AuthenticationEvent.dart';
import 'repos/RailwayStationsApiClient.dart';
import 'repos/RailwayStationsRepository.dart';
import 'repos/UserRepository.dart';
import 'states/AuthenticationState.dart';
import 'views/HomePage.dart';
import 'views/SplashPage.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    //print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  final RailwayStationsRepository railwayStationsRepository =
      RailwayStationsRepository(
    railwayStationsApiClient: RailwayStationsApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(
        userRepository: userRepository,
        railwayStationsRepository: railwayStationsRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final RailwayStationsRepository railwayStationsRepository;

  App(
      {Key key,
      @required this.userRepository,
      @required this.railwayStationsRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Bahnhofsfotos',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xffc71c4d),
        primaryContrastingColor: Color(0xffD0C332),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return BlocProvider(
              create: (context) =>
                  MapBloc(railwayStationsRepository: railwayStationsRepository),
              child: HomePage(),
            );
          }
          if (state is AuthenticationNeeded) {
            return BlocProvider(
              create: (context) =>
                  MapBloc(railwayStationsRepository: railwayStationsRepository),
              child: HomePage(),
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          } else {
            return HomePage();
          }
        },
      ),
    );
  }
}
