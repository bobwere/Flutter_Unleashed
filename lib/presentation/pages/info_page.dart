import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/widgets/info_page_widgets.dart';
import 'package:flutter_unleashed/presentation/widgets/shared/loading_indicator.dart';

const textStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.black87);

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),

          //Title of purpose of this page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: BlocBuilder<RegistrationCubit, RegistrationState>(
                builder: (context, state) {
              return Text(
                state.user == null ? 'Create Profile' : 'Edit Profile',
                style: textStyle.copyWith(fontSize: 18),
              );
            }),
          ),
          SizedBox(height: 20),

          //============ username textfield ===========
          BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
            return CustomTextField(
                isSubmitting: state.isSubmitting,
                textfieldlabel: 'Username',
                keyboardType: TextInputType.name,
                textfieldErrorMessage: state.usernameErrorMessage,
                onTextChanged: (username) {
                  context.read<RegistrationCubit>().usernameChanged(username);
                },
                initialText: state.username,
                hintText: 'e.g Mona Lisa');
          }),
          SizedBox(height: 10),

          //============ email textfield ===========
          BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
            return CustomTextField(
                isSubmitting: state.isSubmitting,
                textfieldlabel: 'Email',
                keyboardType: TextInputType.emailAddress,
                textfieldErrorMessage: state.emailErrorMessage,
                onTextChanged: (email) {
                  context.read<RegistrationCubit>().emailChanged(email);
                },
                initialText: state.email,
                hintText: 'e.g monalisa@gmail.com');
          }),
          SizedBox(height: 10),

          //============ phonenumber textfield ===========
          BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
            return CustomTextField(
                isSubmitting: state.isSubmitting,
                textfieldlabel: 'Phone Number',
                keyboardType: TextInputType.phone,
                textfieldErrorMessage: state.phoneErrorMessage,
                onTextChanged: (phonenumber) {
                  context
                      .read<RegistrationCubit>()
                      .phonenumberChanged(phonenumber);
                },
                initialText: state.phonenumber,
                hintText: 'e.g 0700123456');
          }),

          SizedBox(height: 10),

          BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
            if (state.isSubmitting) {
              return Center(
                  child: BallChasingLoadingIndicator(width: 30, height: 30));
            } else {
              return SizedBox(height: 30);
            }
          }),
          SizedBox(height: MediaQuery.of(context).size.height - 543),

          //============ submit button ===========
          SubmitButton(),
          SizedBox(height: 5)
        ],
      ),
    );
  }
}
