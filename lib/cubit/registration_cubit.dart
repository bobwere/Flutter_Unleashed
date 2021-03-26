import 'package:bloc/bloc.dart';
import 'package:flutter_unleashed/common/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_unleashed/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'registration_state.dart';
part 'registration_cubit.freezed.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._pref) : super(RegistrationState.initial());

  final SharedPreferences _pref;

  void usernameChanged(String username) {
    if (username.length == 0) {
      emit(state.copyWith
          .call(username: username, usernameErrorMessage: NO_USERNAME_MESSAGE));
    } else if (username.length <= 3) {
      emit(state.copyWith.call(
          username: username,
          usernameErrorMessage: USERNAME_MINIMUM_LENGTH_MESSAGE));
    } else {
      emit(state.copyWith.call(username: username, usernameErrorMessage: ''));
    }
  }

  void emailChanged(String email) {
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    emailRegex.hasMatch(email);
    if (email.length == 0) {
      emit(state.copyWith
          .call(email: email, emailErrorMessage: NO_EMAIL_MESSAGE));
    } else if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith
          .call(email: email, emailErrorMessage: ENTER_VALID_EMAIL_MESSAGE));
    } else {
      emit(state.copyWith.call(email: email, emailErrorMessage: ''));
    }
  }

  void phonenumberChanged(String phonenumber) {
    if (phonenumber.length == 0) {
      emit(state.copyWith.call(
          phonenumber: phonenumber,
          phoneErrorMessage: NO_PHONE_NUMBER_MESSAGE));
    } else if (phonenumber.length != 10) {
      emit(state.copyWith.call(
          phonenumber: phonenumber,
          phoneErrorMessage: PHONE_MINIMUM_LENGTH_MESSAGE));
    } else {
      emit(
        state.copyWith.call(phonenumber: phonenumber, phoneErrorMessage: ''),
      );
    }
  }

  void createOrUpdateUserProfile() async {
    emit(state.copyWith.call(
        isSubmitting: true,
        hasSucceeded: false,
        successMessage: '',
        errorMessage: ''));

    await Future.delayed(Duration(seconds: 2));

    final username = _pref.getString(USER_NAME) ?? '';
    bool isUpdatingProfile = username == '' ? false : true;

    bool emailIsValid =
        state.email.isNotEmpty && state.emailErrorMessage.isEmpty;
    bool usernameIsValid =
        state.username.isNotEmpty && state.usernameErrorMessage.isEmpty;
    bool phonenumberIsValid =
        state.phonenumber.isNotEmpty && state.phoneErrorMessage.isEmpty;

    if (emailIsValid && usernameIsValid && phonenumberIsValid) {
      User newUser = User(
          username: state.username,
          email: state.email,
          phonenumber: state.phonenumber);

      await Future.wait([
        _pref.setString(USER_NAME, state.username),
        _pref.setString(USER_EMAIL, state.email),
        _pref.setString(USER_PHONE, state.phonenumber)
      ]);

      emit(state.copyWith.call(
          isSubmitting: false,
          hasSucceeded: true,
          user: newUser,
          errorMessage: '',
          successMessage: isUpdatingProfile
              ? 'Your profile has been updated successfully'
              : 'Your profile has been created successfully'));
    } else {
      usernameChanged(state.username);
      emailChanged(state.email);
      phonenumberChanged(state.phonenumber);
      emit(state.copyWith.call(
          isSubmitting: false,
          errorMessage: 'kindly fill out the form correctly'));
    }
  }

  void getUserProfile() async {
    final username = _pref.getString(USER_NAME) ?? '';
    final useremail = _pref.getString(USER_EMAIL) ?? '';
    final userphone = _pref.getString(USER_PHONE) ?? '';

    if (username.isNotEmpty) {
      User user =
          User(username: username, email: useremail, phonenumber: userphone);

      emit(
        RegistrationState.initial().copyWith.call(
            username: username,
            email: useremail,
            phonenumber: userphone,
            user: user),
      );
    }
  }

  void deleteUserProfile() async {
    emit(state.copyWith
        .call(hasSucceeded: false, successMessage: '', errorMessage: ''));

    await Future.wait([
      _pref.remove(USER_NAME),
      _pref.remove(USER_EMAIL),
      _pref.remove(USER_PHONE),
      _pref.remove(MY_FAVOURITES)
    ]);

    emit(state.copyWith.call(
        email: "",
        username: "",
        phonenumber: "",
        emailErrorMessage: "",
        usernameErrorMessage: "",
        phoneErrorMessage: "",
        isSubmitting: false,
        user: null,
        errorMessage: "",
        hasSucceeded: true,
        successMessage: 'Your profile has been deleted successfully'));
  }
}
