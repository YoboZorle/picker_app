import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

enum BusinessStatusEvent { BLOCKED }

class BusinessStatusBloc extends Bloc<BusinessStatusEvent, BusinessStatusState> {
  BusinessStatusBloc() : super(RiderIsOk());

  @override
  Stream<BusinessStatusState> mapEventToState(
    BusinessStatusEvent event,
  ) async* {
    if (event == BusinessStatusEvent.BLOCKED) {
      yield IsBlocked();
    }
  }
}
