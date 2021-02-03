import 'package:pickrr_app/src/models/driver.dart';

class BusinessTransactionState {
  ///A boolean value that indicates that the an API request is taking place
  final bool isLoading;

  ///Indicates histories fetching failure
  final bool isFailure;

  final bool isInitial;

  /// Indicates data has been fetched successfully
  final bool isSuccess;

  ///List of `History` fetched by the API
  final List<History> histories;

  ///A boolean that checks if page scroll has reached it's max.
  final bool hasReachedMax;

  ///An integer representing the current page in the pagination
  final int currentPage;

  ///integer that represents the last page of the pagination
  final int lastPage;

  BusinessTransactionState(
      {this.isLoading,
        this.isFailure,
        this.isInitial,
        this.isSuccess,
        this.histories,
        this.hasReachedMax,
        this.currentPage,
        this.lastPage});

  ///Empty all checks.
  ///
  ///This is the default/initial state of the bloc
  factory BusinessTransactionState.empty() {
    return BusinessTransactionState(
      isLoading: false,
      isFailure: false,
      isInitial: true,
      isSuccess: false,
      histories: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessTransactionState.loading(previousState) {
    return BusinessTransactionState(
      isLoading: true,
      isFailure: false,
      isInitial: false,
      isSuccess: previousState.isSuccess,
      histories: previousState.histories,
      hasReachedMax: previousState.hasReachedMax,
      currentPage: previousState.currentPage,
      lastPage: previousState.lastPage,
    );
  }

  factory BusinessTransactionState.failure() {
    return BusinessTransactionState(
      isLoading: false,
      isFailure: true,
      isInitial: false,
      isSuccess: false,
      histories: [],
      hasReachedMax: false,
      currentPage: 0,
      lastPage: 0,
    );
  }

  factory BusinessTransactionState.success(
      {List<History> histories, bool hasReachedMax, int currentPage, int lastPage}) {
    return BusinessTransactionState(
      isLoading: false,
      isFailure: false,
      isInitial: false,
      isSuccess: true,
      histories: histories,
      hasReachedMax: hasReachedMax,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }

  BusinessTransactionState copyWith(
      {bool isLoading,
        bool isInitial,
        bool isFailure,
        bool isSuccess,
        List<History> histories,
        bool hasReachedMax,
        int currentPage,
        int lastPage}) {
    return BusinessTransactionState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? this.isFailure,
        isInitial: isInitial ?? this.isInitial,
        isSuccess: isSuccess ?? this.isSuccess,
        histories: histories ?? this.histories,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage);
  }

  @override
  String toString() {
    return '''BusinessTransactionState {
      isLoading: $isLoading,
      isInitial: $isInitial,
      isFailure: $isFailure,
      isSuccess: $isSuccess,
      histories: ${histories.length},
      hasReachedMax: $hasReachedMax,
      currentPage: $currentPage,
      lastPage: $lastPage,
    }''';
  }
}