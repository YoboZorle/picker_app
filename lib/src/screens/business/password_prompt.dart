import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/widgets/passcode/create_pin.dart';
import 'package:pickrr_app/src/widgets/passcode/enter_pin.dart';

class PasswordPrompt extends StatelessWidget {
  final bool isNewBusiness;
  final String nextRoute;

  PasswordPrompt(this.isNewBusiness, {this.nextRoute = '/BusinessHomePage'});

  @override
  Widget build(BuildContext context) {
    if (isNewBusiness) {
      return CreatePinWidget(nextRoute: nextRoute);
    }
    return BlocProvider<AuthenticationBloc>(
        create: (_) =>
            AuthenticationBloc()..add(AuthenticationEvent.APP_STARTED),
        child: EnterPinWidget(nextRoute: nextRoute));
  }
}
