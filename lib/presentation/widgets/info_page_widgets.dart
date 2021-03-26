import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () {
            if (!state.isSubmitting)
              FocusScope.of(context).requestFocus(new FocusNode());
            context.read<RegistrationCubit>().createOrUpdateUserProfile();
          },
          style: TextButton.styleFrom(
            textStyle: textStyle.copyWith(color: Color(0xFFFFFFF)),
            primary: Colors.white,
            backgroundColor: Color(0xFF4268FF),
            onSurface: Colors.grey,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          child: Text(state.user == null ? 'Create Profile' : 'Update Profile'),
        ),
      );
    });
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key key,
      @required this.textfieldlabel,
      @required this.textfieldErrorMessage,
      @required this.onTextChanged,
      @required this.initialText,
      @required this.hintText,
      @required this.isSubmitting,
      @required this.keyboardType})
      : super(key: key);

  final String textfieldlabel;
  final String initialText;
  final String hintText;
  final bool isSubmitting;
  final String textfieldErrorMessage;
  final TextInputType keyboardType;
  final void Function(String value) onTextChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.initialText;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color containerColor;
    Color textColor;
    Widget confirmationIcon;
    if (widget.initialText.isNotEmpty && widget.textfieldErrorMessage.isEmpty) {
      borderColor = Color(0xFF4268FF);
      textColor = Color(0xFF4268FF);
      containerColor = Color(0xFFE8EDFF);
      confirmationIcon =
          Icon(LineAwesomeIcons.check_circle, color: Color(0xFF4268FF));
    } else if (widget.initialText.isEmpty &&
        widget.textfieldErrorMessage.isEmpty) {
      borderColor = Color(0xFFA2A2A5);
      containerColor = Color(0xFFFFFFFF);
      confirmationIcon = Container(height: 24, width: 24);
    } else {
      borderColor = Color(0xFFE35D69);
      textColor = Color(0xFFE35D69);
      containerColor = Color(0xFFFADEE1);
      confirmationIcon =
          Icon(LineAwesomeIcons.info_circle, color: Color(0xFFE35D69));
    }

    return BlocListener<RegistrationCubit, RegistrationState>(
        listenWhen: (p, c) {
          return p.user != null && c.user == null;
        },
        listener: (context, state) {
          if (state.user == null) {
            _textEditingController.text = '';
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.textfieldlabel,
                    style: textStyle.copyWith(color: Color(0xFFA2A2A5)),
                  ),
                  Text(
                    widget.textfieldErrorMessage,
                    style: textStyle.copyWith(color: Color(0xFFE35D69)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !widget.isSubmitting,
                      controller: _textEditingController,
                      style: textStyle.copyWith(color: textColor),
                      keyboardType: widget.keyboardType,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.hintText,
                          hintStyle:
                              textStyle.copyWith(color: Color(0xFFA2A2A5)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true),
                      onChanged: (_) =>
                          widget.onTextChanged(_textEditingController.text),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: confirmationIcon)
                ],
              ),
            ),
          ],
        ));
  }
}
