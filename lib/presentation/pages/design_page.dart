import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';
import 'package:flutter_unleashed/presentation/widgets/design_page_widgets.dart';

class DesignPage extends StatefulWidget {
  const DesignPage(
      {Key key,
      @required this.onEditPressed,
      @required this.onFavouritePressed})
      : super(key: key);
  final Function onEditPressed;
  final Function onFavouritePressed;

  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state.user == null) {
          return Column(
            children: [
              DesignPageEmptyState(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: widget.onEditPressed,
                  style: TextButton.styleFrom(
                    textStyle: textStyle.copyWith(color: Color(0xFFFFFFF)),
                    primary: Colors.white,
                    backgroundColor: Color(0xFF4268FF),
                    onSurface: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text('Create Profile'),
                ),
              ),
              SizedBox(height: 5),
            ],
          );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                ProfileCard(onEditPressed: widget.onEditPressed),
                SizedBox(height: 5),
                QouteOfTheDay(),
                SizedBox(height: 10),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                SizedBox(height: 10),
                FavouritesHeading(),
                SizedBox(height: 10),
                FavouritePokemonsGridView(
                    onFavouritePressed: widget.onFavouritePressed)
              ],
            ),
          );
        }
      },
    );
  }
}
