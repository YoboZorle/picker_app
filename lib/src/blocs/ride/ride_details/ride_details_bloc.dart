import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class RideDetailsBloc extends Bloc<RideDetailsEvent, RideDetailsState> {
  RideDetailsBloc() : super(EmptyDetails());

  @override
  Stream<RideDetailsState> mapEventToState(
    RideDetailsEvent event,
  ) async* {
    if (event is RideDetailsLoaded) {
      yield* _mapRideDetailsLoadedToState(event.rideDetails);
    }
  }

  Stream<RideDetailsState> _mapRideDetailsLoadedToState(
      Map rideDetails) async* {
    yield RideDetails(rideDetails);
  }
}
