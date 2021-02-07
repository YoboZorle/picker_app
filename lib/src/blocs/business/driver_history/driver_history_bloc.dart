import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/business/driver_history/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class BusinessRideHistoryBloc extends Bloc<BusinessRideHistoryEvent, BusinessRideHistoryState> {
  final BusinessRepository _businessRepository = BusinessRepository();

  BusinessRideHistoryBloc() : super(BusinessRideHistoryState.empty());

  @override
  Stream<BusinessRideHistoryState> mapEventToState(BusinessRideHistoryEvent event) async* {
    final currentState = state;

    if (event is BusinessRideHistoryReset) {
      yield BusinessRideHistoryState.empty();
    }

    if (event is BusinessRideHistoryFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapBusinessRideHistoryFetchedToState(currentState, event.riderId);
      }
    }
  }

  Stream<BusinessRideHistoryState> _mapBusinessRideHistoryFetchedToState(
      currentState, int riderId) async* {
    yield BusinessRideHistoryState.loading(currentState);

    try {
      final nextPage =
      currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result = await _fetchDriverHistoryAndGetPages(nextPage, riderId);
      bool hasReachedMax = false;
      var rides = result['rides'];

      if (currentState.isInitial) {
        hasReachedMax = result['currentPage'] + 1 > result['lastPage'];
      }
      if (!currentState.isInitial) {
        if (nextPage >= result['lastPage']) {
          hasReachedMax = true;
        }
        rides = currentState.rides + rides;
      }
      yield BusinessRideHistoryState.success(
        rides: rides,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield BusinessRideHistoryState.failure();
    }
  }

  bool _hasReachedMax(BusinessRideHistoryState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchDriverHistoryAndGetPages(nextPage, int riderId) async {
    try {
      final response = await _businessRepository.getRiderHistory(riderId, page: nextPage);
      if (response == null) {
        return {'rides': [], 'currentPage': 1, 'lastPage': 1};
      }
      final List<Ride> rides = _rideDetails(response['results']);

      final int currentPage = response['pagination']['current_page'];
      final int lastPage = response['pagination']['last_page'];
      return {
        'rides': rides,
        'currentPage': currentPage,
        'lastPage': lastPage
      };
    } catch (e) {
      throw Exception('error fetching rides');
    }
  }

  List<Ride> _rideDetails(rawData) {
    List<Ride> rides = [];
    rawData.forEach((rawDetail) {
      Ride ride = Ride.fromMap(rawDetail);
      rides.add(ride);
    });

    return rides;
  }
}