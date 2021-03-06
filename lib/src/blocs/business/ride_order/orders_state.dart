import 'package:pickrr_app/src/models/ride.dart';

class BusinessRideOrdersState {
  ///A boolean value that indicates that the an API request is taking place
  final bool isLoading;

  ///Indicates rides fetching failure
  final bool isFailure;

  final bool isInitial;

  /// Indicates data has been fetched successfully
  final bool isSuccess;

  ///List of `Rides` fetched by the API
  final List<Ride> rides;

  ///A boolean that checks if page scroll has reached it's max.
  final bool hasReachedMax;

  ///An integer representing the current page in the pagination
  final int currentPage;

  ///integer that represents the last page of the pagination
  final int lastPage;

  BusinessRideOrdersState(
      {this.isLoading,
        this.isFailure,
        this.isInitial,
        this.isSuccess,
        this.rides,
        this.hasReachedMax,
        this.currentPage,
        this.lastPage});

  ///Empty all checks.
  ///
  ///This is the default/initial state of the bloc
  factory BusinessRideOrdersState.empty() {
    return BusinessRideOrdersState(
      isLoading: false,
      isFailure: false,
      isInitial: true,
      isSuccess: false,
      rides: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessRideOrdersState.loading(previousState) {
    return BusinessRideOrdersState(
      isLoading: true,
      isFailure: false,
      isInitial: false,
      isSuccess: previousState.isSuccess,
      rides: previousState.rides,
      hasReachedMax: previousState.hasReachedMax,
      currentPage: previousState.currentPage,
      lastPage: previousState.lastPage,
    );
  }

  factory BusinessRideOrdersState.failure() {
    return BusinessRideOrdersState(
      isLoading: false,
      isFailure: true,
      isInitial: false,
      isSuccess: false,
      rides: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessRideOrdersState.success(
      {List<Ride> rides, bool hasReachedMax, int currentPage, int lastPage}) {
    return BusinessRideOrdersState(
      isLoading: false,
      isFailure: false,
      isInitial: false,
      isSuccess: true,
      rides: rides,
      hasReachedMax: hasReachedMax,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }

  BusinessRideOrdersState copyWith(
      {bool isLoading,
        bool isInitial,
        bool isFailure,
        bool isSuccess,
        List<Ride> rides,
        bool hasReachedMax,
        int currentPage,
        int lastPage}) {
    return BusinessRideOrdersState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? this.isFailure,
        isInitial: isInitial ?? this.isInitial,
        isSuccess: isSuccess ?? this.isSuccess,
        rides: rides ?? this.rides,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage);
  }

  @override
  String toString() {
    return '''BusinessRideOrdersState {
      isLoading: $isLoading,
      isInitial: $isInitial,
      isFailure: $isFailure,
      isSuccess: $isSuccess,
      rides: ${rides.length},
      hasReachedMax: $hasReachedMax,
      currentPage: $currentPage,
      lastPage: $lastPage,
    }''';
  }
}