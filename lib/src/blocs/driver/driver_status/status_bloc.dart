import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'bloc.dart';

class DriverStatusBloc
    extends Bloc<DriverStatusEvent, bool> {
  DriverRepository _driverRepository = DriverRepository();

  DriverStatusBloc() : super(false);

  @override
  Stream<bool> mapEventToState(
      DriverStatusEvent event,
      ) async* {
    if (event is StatusUpdated) {
      yield* _mapStatusUpdatedToState(event.status);
    }
  }

  Stream<bool> _mapStatusUpdatedToState(String status) async* {
    try {
      await _driverRepository.updateStatus(status: status);
      yield true;
    } catch (err) {
      debugLog(err);
      yield false;
    }
  }
}
