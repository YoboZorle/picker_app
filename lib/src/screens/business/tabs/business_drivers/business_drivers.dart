import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/business/riders/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_driver_activity.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:pickrr_app/src/widgets/nav_drawer.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class BusinessDrivers extends StatefulWidget {
  final String title;

  BusinessDrivers({Key key, this.title}) : super(key: key);

  @override
  _BusinessDriversState createState() => _BusinessDriversState();
}

class _BusinessDriversState extends State<BusinessDrivers> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  BusinessRidersBloc _ridersBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _ridersBloc = BlocProvider.of<BusinessRidersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Drivers',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Ubuntu')),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            children: [
              RaisedButton(
                  elevation: 8,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/NewBusinessRiderApplication');
                  },
                  color: AppColor.primaryText,
                  child: Text('Add driver',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Ubuntu'))),
              SizedBox(width: 20)
            ],
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: BusinessNavDrawer(),
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
          child: BlocBuilder<BusinessRidersBloc, BusinessRidersState>(
              // ignore: missing_return
              builder: (_, state) {
        if (state.isFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text("No driver!"),
                alignment: Alignment.center,
              ),
            ],
          );
        }
        if (state.isInitial || !state.isSuccess && state.isLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              ),
            ],
          );
        }
        if (state.isSuccess) {
          if (state.drivers.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("No driver!"),
                  alignment: Alignment.center,
                ),
              ],
            );
          }
          return ListView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: state.hasReachedMax
                ? state.drivers.length
                : state.drivers.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.drivers.length) {
                return PreLoader();
              }
              Driver driver = state.drivers[index];
              return Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    driver.details.fullname,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Ubuntu'),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.isDriverAvailable
                            ? 'Driver is available'
                            : 'Driver not available',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            height: 1.3,
                            fontFamily: 'Ubuntu'),
                      ),
                    ],
                  ),
                  leading: ClipOval(
                      child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(color: Colors.white),
                          child: driver.details.profileImageUrl != null ||
                                  driver.details.profileImageUrl.isNotEmpty
                              ? CustomImage(
                                  imageUrl: '${driver.details.profileImageUrl}',
                                )
                              : Image.asset('placeholder.jpg',
                                  width: double.infinity,
                                  height: double.infinity))),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,
                      size: 15, color: Colors.grey[400]),
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/DriverActivities/${driver.id}');
                  },
                ),
              );
            },
          );
        }
      }), onRefresh: () async {
        _ridersBloc.add(RidersFetchReset());
        _ridersBloc.add(RidersFetched());
      }),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _ridersBloc.add(RidersFetched());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ridersBloc.add(RidersFetchReset());
    super.dispose();
  }
}
