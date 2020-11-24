import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/custom_route.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/screens/auth/complete_profile_form.dart';
import 'package:pickrr_app/src/screens/home.dart';
import 'package:pickrr_app/src/screens/onboard.dart';

class Routes {
  static dynamic route() {
    return {
      '/': (BuildContext context) => BlocProvider<AuthenticationBloc>(
          create: (_) =>
              AuthenticationBloc()..add(AuthenticationEvent.APP_STARTED),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (_, state) {
            return homePage(context, state);
          })),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "Onboard":
        return CustomRoute<bool>(builder: (BuildContext context) => Onboard());
      default:
        return onUnknownRoute(RouteSettings(name: '/Unknown'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('${settings.name.split('/')[1]} Not available...'),
        ),
      ),
    );
  }
}

Widget homePage(BuildContext context, AuthenticationState state) {
  if (state is UnDetermined || state is NonLoggedIn) {
    return Onboard();
  }

  User user = state.props[0];
  if (user.email == null ||
      user.email.isEmpty ||
      user.profileImageUrl == null ||
      user.profileImageUrl.isEmpty) {
    return CompleteProfileForm();
  }

  return Home();
}
