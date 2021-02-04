import 'package:pickrr_app/src/models/driver.dart';

class BusinessRidersState {
  ///A boolean value that indicates that the an API request is taking place
  final bool isLoading;

  ///Indicates Drivers fetching failure
  final bool isFailure;

  final bool isInitial;

  /// Indicates data has been fetched successfully
  final bool isSuccess;

  ///List of `Driver`s fetched by the API
  final List<Driver> drivers;

  ///A boolean that checks if page scroll has reached it's max.
  final bool hasReachedMax;

  ///An integer representing the current page in the pagination
  final int currentPage;

  ///integer that represents the last page of the pagination
  final int lastPage;

  BusinessRidersState(
      {this.isLoading,
        this.isFailure,
        this.isInitial,
        this.isSuccess,
        this.drivers,
        this.hasReachedMax,
        this.currentPage,
        this.lastPage});

  ///Empty all checks.
  ///
  ///This is the default/initial state of the bloc
  factory BusinessRidersState.empty() {
    return BusinessRidersState(
      isLoading: false,
      isFailure: false,
      isInitial: true,
      isSuccess: false,
      drivers: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessRidersState.loading(previousState) {
    return BusinessRidersState(
      isLoading: true,
      isFailure: false,
      isInitial: false,
      isSuccess: previousState.isSuccess,
      drivers: previousState.drivers,
      hasReachedMax: previousState.hasReachedMax,
      currentPage: previousState.currentPage,
      lastPage: previousState.lastPage,
    );
  }

  factory BusinessRidersState.failure() {
    return BusinessRidersState(
      isLoading: false,
      isFailure: true,
      isInitial: false,
      isSuccess: false,
      drivers: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessRidersState.success(
      {List<Driver> drivers,
        bool hasReachedMax,
        int currentPage,
        int lastPage}) {
    return BusinessRidersState(
      isLoading: false,
      isFailure: false,
      isInitial: false,
      isSuccess: true,
      drivers: drivers,
      hasReachedMax: hasReachedMax,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }

  BusinessRidersState copyWith(
      {bool isLoading,
        bool isInitial,
        bool isFailure,
        bool isSuccess,
        List<Driver> drivers,
        bool hasReachedMax,
        int currentPage,
        int lastPage}) {
    return BusinessRidersState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? this.isFailure,
        isInitial: isInitial ?? this.isInitial,
        isSuccess: isSuccess ?? this.isSuccess,
        drivers: drivers ?? this.drivers,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage);
  }

  @override
  String toString() {
    return '''BusinessRidersState {
      isLoading: $isLoading,
      isInitial: $isInitial,
      isFailure: $isFailure,
      isSuccess: $isSuccess,
      drivers: ${drivers.length},
      hasReachedMax: $hasReachedMax,
      currentPage: $currentPage,
      lastPage: $lastPage,
    }''';
  }
}
