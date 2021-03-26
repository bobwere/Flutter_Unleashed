part of 'registration_cubit.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @required String email,
    @required String username,
    @required String phonenumber,
    @required String emailErrorMessage,
    @required String usernameErrorMessage,
    @required String phoneErrorMessage,
    @required bool isSubmitting,
    User user,
    @required bool hasSucceeded,
    @required String errorMessage,
    @required String successMessage,
  }) = _RegistrationState;

  factory RegistrationState.initial() => RegistrationState(
        email: "",
        username: "",
        phonenumber: "",
        emailErrorMessage: "",
        usernameErrorMessage: "",
        phoneErrorMessage: "",
        isSubmitting: false,
        user: null,
        hasSucceeded: false,
        errorMessage: "",
        successMessage: "",
      );
}
