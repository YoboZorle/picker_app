import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

enum RiderDetailsEvent { BLOCKED_RIDER, RIDER_IS_DELIVERING }

class RiderDetailsBloc extends Bloc<RiderDetailsEvent, RiderDetailsState> {
  RiderDetailsBloc() : super(RiderIsOk());

  @override
  Stream<RiderDetailsState> mapEventToState(
    RiderDetailsEvent event,
  ) async* {
    if (event == RiderDetailsEvent.BLOCKED_RIDER) {
      yield IsBlocked();
    } else if (event == RiderDetailsEvent.RIDER_IS_DELIVERING) {
      yield IsRiding();
    }
  }
}
