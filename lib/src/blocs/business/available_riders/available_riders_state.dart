import 'package:pickrr_app/src/models/driver.dart';

class AvailableRidersState {
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

  AvailableRidersState(
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
  factory AvailableRidersState.empty() {
    return AvailableRidersState(
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

  factory AvailableRidersState.loading(previousState) {
    return AvailableRidersState(
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

  factory AvailableRidersState.failure() {
    return AvailableRidersState(
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

  factory AvailableRidersState.success(
      {List<Driver> drivers,
      bool hasReachedMax,
      int currentPage,
      int lastPage}) {
    return AvailableRidersState(
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

  AvailableRidersState copyWith(
      {bool isLoading,
      bool isInitial,
      bool isFailure,
      bool isSuccess,
      List<Driver> drivers,
      bool hasReachedMax,
      int currentPage,
      int lastPage}) {
    return AvailableRidersState(
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
    return '''AvailableRidersState {
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
