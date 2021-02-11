import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:pickrr_app/src/blocs/business/driver_history/bloc.dart';
import 'package:pickrr_app/src/blocs/business/driver_wallet_history/bloc.dart';
import 'package:pickrr_app/src/blocs/driver/rated_rides/bloc.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/business/driver_reviews.dart';
import 'package:pickrr_app/src/widgets/business/driver_ride_history.dart';
import 'package:pickrr_app/src/widgets/business/driver_transaction.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class DriverActivitiesDetails extends StatelessWidget {
  final int riderId;
  final BusinessRepository _businessRepository = BusinessRepository();

  DriverActivitiesDetails(this.riderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Driver',
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
        iconTheme: IconThemeData(color: Colors.black, size: 10.0),
        actions: <Widget>[
          FutureBuilder(
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.hasData == null ||
                    !snapshot.hasData) {
                  return Container();
                }
                final Driver driverDetails = snapshot.data;
                return DriverBlocking(riderId, driverDetails.blocked);
              },
              future: _businessRepository.getDriverFromStorage(riderId))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DetailsSection(riderId),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicatorPadding: EdgeInsets.only(left: 50, right: 50, top: 50),
                indicatorWeight: 3,
                unselectedLabelStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Ubuntu'),
                labelStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Ubuntu'),
                physics: BouncingScrollPhysics(),
                tabs: [
                  Tab(text: 'Rides'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Transactions'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    BlocProvider<BusinessRideHistoryBloc>(
                        create: (_) => BusinessRideHistoryBloc(),
                        child: DriverRideHistory(riderId: riderId)),
                    BlocProvider<RatedRidesBloc>(
                        create: (_) => RatedRidesBloc(),
                        child: DriverReviews(riderId: riderId)),
                    BlocProvider<DriverWalletHistoryBloc>(
                        create: (_) => DriverWalletHistoryBloc(),
                        child: DriverTransaction(riderId: riderId))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DriverBlocking extends StatefulWidget {
  final int riderId;
  final bool riderBlockingStatus;

  DriverBlocking(this.riderId, this.riderBlockingStatus);

  @override
  _DriverBlockingState createState() => _DriverBlockingState();
}

class _DriverBlockingState extends State<DriverBlocking> {
  final BusinessRepository _businessRepository = BusinessRepository();
  bool _riderBlockingStatus;

  @override
  void initState() {
    _riderBlockingStatus = widget.riderBlockingStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _handleRiderBlockingUpdate,
      itemBuilder: (BuildContext popUpMenuContext) {
        Set<String> riderState = {
          _riderBlockingStatus ? 'Unblock rider' : 'Block rider'
        };
        return riderState.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice,
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w400,
                    fontSize: 15)),
          );
        }).toList();
      },
    );
  }

  void _handleRiderBlockingUpdate(String value) async {
    switch (value) {
      case 'Block rider':
        _processRequest('block');
        setState(() {
          _riderBlockingStatus = true;
        });
        break;
      case 'Unblock rider':
        _processRequest('unblock');
        setState(() {
          _riderBlockingStatus = false;
        });
        break;
    }
  }

  void _processRequest(String status) async {
    await _businessRepository.updateRiderBlockingStatus(
        status: status, riderId: widget.riderId);
  }
}

class DetailsSection extends StatefulWidget {
  final int riderId;

  DetailsSection(this.riderId);

  @override
  _DetailsSectionState createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  final BusinessRepository _businessRepository = BusinessRepository();
  bool _driverStatus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == null ||
              !snapshot.hasData) {
            return Container();
          }
          final Driver driverDetails = snapshot.data;
          _driverStatus = driverDetails.status == 'A' ? true : false;
          return Column(
            children: [
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: ClipOval(
                        child: Container(
                      height: 85.0,
                      width: 85.0,
                      child: !driverDetails.details.noProfileImage
                          ? CustomImage(
                              imageUrl:
                                  '${driverDetails.details.profileImageUrl}',
                            )
                          : Image.asset('assets/images/placeholder.jpg',
                              width: double.infinity, height: double.infinity),
                    )),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                            '${driverDetails.bikeBrand} - ${driverDetails.plateNumber}',
                            style: TextStyle(
                                fontSize: 12.0,
                                height: 1.3,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                        Text(
                          driverDetails.details.fullname,
                          style: TextStyle(
                              fontSize: 16.0,
                              height: 1.3,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        Text('Ticket ID - ${driverDetails.ticketNumber}',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                height: 1.4,
                                fontWeight: FontWeight.w400)),
                        Text(
                            '+${driverDetails.details.callingCode}${driverDetails.details.phone}',
                            style: TextStyle(
                                fontSize: 13.0,
                                height: 1.3,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Text(driverDetails.details.email,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                height: 1.3,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  height: 0.7,
                  margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300]),
              DriverAvailabilityBar(_driverStatus, widget.riderId),
              Container(
                  height: 0.7,
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300]),
            ],
          );
        },
        future: _businessRepository.getDriverFromStorage(widget.riderId));
  }
}

class DriverAvailabilityBar extends StatefulWidget {
  final bool driverStatus;
  final int riderId;

  DriverAvailabilityBar(this.driverStatus, this.riderId);

  @override
  _DriverAvailabilityBarState createState() => _DriverAvailabilityBarState();
}

class _DriverAvailabilityBarState extends State<DriverAvailabilityBar> {
  bool _driverStatus = true;
  final BusinessRepository _businessRepository = BusinessRepository();

  @override
  void initState() {
    _driverStatus = widget.driverStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
        child: ListTileSwitch(
          contentPadding: EdgeInsets.all(0),
          visualDensity: VisualDensity.comfortable,
          value: _driverStatus,
          onChanged: (value) {
            setState(() {
              _driverStatus = value;
            });
            _updateRiderStatus(value == true ? 'A' : 'NA');
          },
          toggleSelectedOnValueChange: true,
          subtitle: Text('Toggle button to activate or deactivate your driver.',
              style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: "Ubuntu",
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  height: 1.5)),
          switchActiveColor: Colors.green,
          switchType: SwitchType.cupertino,
          title: Text(_driverStatus ? 'Driver Available' : 'Driver Unavailable',
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.w400,
                  height: 1.6)),
        ),
      ),
    );
  }

  _updateRiderStatus(String status) async {
    await _businessRepository.updateDriverStatus(
        status: status, riderId: widget.riderId);
  }
}
