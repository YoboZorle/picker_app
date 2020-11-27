class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    this.isLoading,
    this.isSuccess,
    this.isFailure,
  });

  factory LoginState.empty() {
    return LoginState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isLoading: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isLoading: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(
      isLoading: isSubmitting ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isSubmitting: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
