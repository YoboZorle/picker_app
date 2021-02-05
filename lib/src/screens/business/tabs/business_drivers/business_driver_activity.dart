import 'package:flutter/material.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/business/ride_interaction_layout.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class BusinessDriverActivity extends StatelessWidget {
  final int riderId;
  final BusinessRepository _businessRepository = BusinessRepository();

  BusinessDriverActivity(this.riderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                centerTitle: true,
                title: Text(
                  'Ride Activity',
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
                    FutureBuilder(
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.none ||
                              snapshot.hasData == null ||
                              !snapshot.hasData) {
                            return Container();
                          }
                          final rawDetails = snapshot.data;
                          if (rawDetails == null) {
                            return Container();
                          }
                          Ride ride = Ride.fromMap(rawDetails);
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              RideInteraction(ride),
                            ],
                          );
                        },
                        future:
                            _businessRepository.getRiderCurrentRide(riderId)),
                    SizedBox(height: 5),
                    FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.none ||
                              snapshot.hasData == null ||
                              !snapshot.hasData) {
                            return Container();
                          }
                          final driverDetails = snapshot.data;
                          return InkWell(
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15),
                                child: ListTile(
                                  leading: ClipOval(
                                      child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: !driverDetails.details.noProfileImage
                                        ? CustomImage(
                                            imageUrl:
                                                '${driverDetails.details.profileImageUrl}',
                                          )
                                        : Image.asset('placeholder.jpg',
                                            width: double.infinity,
                                            height: double.infinity),
                                  )),
                                  title: Text(
                                    driverDetails.details.fullname,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        height: 1.6),
                                  ),
                                  subtitle: Text(
                                    'View your driver details',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                  ),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.grey[300],
                                      size: 20),
                                  contentPadding: EdgeInsets.all(0),
                                  dense: true,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/DriverActivitiesDetails/$riderId');
                            },
                          );
                        },
                        future:
                            _businessRepository.getDriverFromStorage(riderId)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
