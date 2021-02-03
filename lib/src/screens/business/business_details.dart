import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class BusinessProfile extends StatelessWidget {
  final BusinessRepository _businessRepository = BusinessRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (_, state) {
            if (state is NonLoggedIn) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.pushReplacementNamed(context, '/'));
            }
            if (state.props.isEmpty) {
              return Container();
            }
            User user = state.props[0];

            return FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.hasData == null ||
                      !snapshot.hasData) {
                    return Container();
                  }
                  final businessDetails = snapshot.data;
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        brightness: Brightness.light,
                        centerTitle: true,
                        title: Text(
                          'Business Profile',
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
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: 10),
                            Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: ListTile(
                                  leading: ClipOval(
                                      child: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: businessDetails.logo != null ||
                                                  businessDetails
                                                      .logo.isNotEmpty
                                              ? CustomImage(
                                                  imageUrl:
                                                      '${APIConstants.assetsUrl}${businessDetails.logo}',
                                                )
                                              : Image.asset('placeholder.jpg',
                                                  width: double.infinity,
                                                  height: double.infinity))),
                                  title: Text(
                                    businessDetails.name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6),
                                  ),
                                  subtitle: Text(
                                    'Business name',
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                                    businessDetails.email,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6),
                                  ),
                                  subtitle: Text(
                                    'Business email',
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                                    businessDetails.phone,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6),
                                  ),
                                  subtitle: Text(
                                    'Business phone number',
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                                    businessDetails.location,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6),
                                  ),
                                  subtitle: Text(
                                    'State/City',
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                                        title:
                                            'Are you sure you want to leave?',
                                        titleTextColor: Colors.white,
                                        icon: Icons.eighteen_mp,
                                        infoMessage: '',
                                        onPressedYes: () {
                                          BlocProvider.of<AuthenticationBloc>(
                                                  context)
                                              .add(AuthenticationEvent
                                                  .LOGGED_OUT);
                                        });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                future: _businessRepository
                    .getBusinessFromStorage(user.businessId));
          }),
        ));
  }
}
