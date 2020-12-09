import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class DriverProfile extends StatelessWidget {
  final DriverRepository _driverRepository = DriverRepository();

  DriverProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Driver Profile',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Ubuntu",
              fontWeight: FontWeight.w800,
            )),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (_, state) {
        if (state is NonLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.pushReplacementNamed(context, '/'));
        }
        if (state.props.isEmpty) {
          return Container();
        }
        User user = state.props[0];

        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                    child: Container(
                  height: 115.0,
                  width: 115.0,
                  child: CustomImage(
                    imageUrl:
                        '${APIConstants.assetsUrl}${user.profileImageUrl}',
                  ),
                )),
                SizedBox(height: 15),
                Text(user.fullname,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryText,
                      fontFamily: "Ubuntu",
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 4),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.hasData == null || !snapshot.hasData) {
                      return Container();
                    }
                    final driverDetails = snapshot.data;
                    return Column(
                      children: [
                        Text('1,320 finished rides',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(height: 4),
                        Text('Started ${getdob(driverDetails.createdAt)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.primaryText,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(driverDetails.companyName,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 5,
                              width: 5,
                              margin:
                                  EdgeInsets.only(top: 3, left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            Text(driverDetails.ticketNumber,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ],
                    );
                  },
                  future: _driverRepository.getDriverDetailsFromStorage(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
