import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/models/user.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
      if (state is NonLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushReplacementNamed(context, '/'));
      }
      if (state.props.isEmpty) {
        return Container();
      }
      User user = state.props[0];

      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                centerTitle: true,
                title: Text(
                  'My Profile',
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            user.fullname,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'Full name',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            user.email,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'My email',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            '+${user.callingCode}${user.phone}',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'My phone number',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOG OUT',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          onTap: () {
                            ConfirmAlertBoxDark(
                                context: context,
                                title: 'Are you sure you want to leave?',
                                titleTextColor: Colors.white,
                                icon: Icons.eighteen_mp,
                                infoMessage: '',
                                onPressedYes: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationEvent.LOGGED_OUT);
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
