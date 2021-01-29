import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/driver/driver_status/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/utils/switch/lite_rolling_switch.dart';

class CustomerAppBar extends StatelessWidget {
  final DriverRepository _driverRepository = DriverRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.menu_sharp,
                            size: 25,
                          ),
                        )),
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  }),
              BlocBuilder<DriverStatusBloc, bool>(builder: (_, state) {
                return Row(
                  children: [
                    SizedBox(
                        height: 38,
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none ||
                                snapshot.hasData == null ||
                                !snapshot.hasData) {
                              return Container();
                            }
                            final driverDetails = snapshot.data;
                            return LiteRollingSwitch(
                              value: driverDetails.status == 'A' ? true : false,
                              textOn: 'Online',
                              textOff: 'Offline',
                              colorOn: AppColor.primaryText,
                              colorOff: Colors.grey[400],
                              iconOn: Icons.directions_bike,
                              iconOff: Icons.power_settings_new,
                              onChanged: (bool state) {
                                BlocProvider.of<DriverStatusBloc>(context).add(
                                  StatusUpdated(
                                      status: state == true ? 'A' : 'NA'),
                                );
                              },
                            );
                          },
                          future:
                              _driverRepository.getDriverDetailsFromStorage(),
                        )),
                  ],
                );
              }),
            ],
          )),
    );
  }
}
