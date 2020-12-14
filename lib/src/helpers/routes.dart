import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/blocs/login/bloc.dart';
import 'package:pickrr_app/src/blocs/ride/orders/bloc.dart';
import 'package:pickrr_app/src/helpers/custom_route.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/screens/auth/complete_profile_form.dart';
import 'package:pickrr_app/src/screens/auth/login.dart';
import 'package:pickrr_app/src/screens/auth/otp_verification.dart';
import 'package:pickrr_app/src/screens/driver/onboard.dart';
import 'package:pickrr_app/src/screens/home.dart';
import 'package:pickrr_app/src/screens/onboard.dart';
import 'package:pickrr_app/src/screens/driver/main_activity.dart';
import 'package:pickrr_app/src/screens/driver/driver_form.dart';
import 'package:pickrr_app/src/screens/ride/review_order.dart';
import 'package:pickrr_app/src/screens/ride/ride_details.dart';
import 'package:pickrr_app/src/screens/ride/ride_history.dart';
import 'package:pickrr_app/src/user/user_profile/user_profile.dart';

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
      case "DriversHomePage":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc()
                  ..add(AuthenticationEvent.AUTHENTICATED),
                child: DriverTabs()));
      case "Login":
        return SlideLeftRoute<bool>(builder: (BuildContext context) => Login());
      case "DriverOnboard":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => DriverOnboard());
      case "DriverApplication":
        return CustomRoute<bool>(
            builder: (BuildContext context) => DriverApplication());
      case "OTPVerification":
        String phone;
        String callingCode;
        if (pathElements.length > 2) {
          phone = pathElements[2];
          callingCode = pathElements[3];
        }
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
                    BlocProvider<AuthenticationBloc>(
                        create: (_) => AuthenticationBloc())
                  ],
                  child: OTPVerification(
                    phone: phone,
                    callingCode: callingCode,
                  ),
                ));
      case "CompleteProfileDetails":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => CompleteProfileForm());
      case "ProfileDetails":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc()
                  ..add(AuthenticationEvent.AUTHENTICATED),
                child: UserProfile()));
      case "ReviewOrderPage":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc()
                  ..add(AuthenticationEvent.AUTHENTICATED),
                child: ReviewOrder(settings.arguments)));
      case "RideDetails":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => RideDetails(settings.arguments));
      case "RideHistory":
        return CustomRoute<bool>(
            builder: (BuildContext context) => BlocProvider<RideOrdersBloc>(
                create: (_) => RideOrdersBloc()..add(OrdersFetched()),
                child: RideHistory()));
      case "HomePage":
        return SlideLeftRoute<bool>(
            builder: (BuildContext context) => BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc()
                  ..add(AuthenticationEvent.AUTHENTICATED),
                child: Home()));
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
  if (!user.isCompleteDetails) {
    return CompleteProfileForm();
  }

  if (user.isDriver) {
    return DriverTabs();
  }

  return Home();
}
