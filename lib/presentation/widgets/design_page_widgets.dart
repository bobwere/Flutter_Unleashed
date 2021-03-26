import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:flutter_unleashed/cubit/pokemon_cubit.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';

final _blackText =
    TextStyle(color: Colors.black87, fontFamily: 'Poppins', fontSize: 16);

class DesignPageEmptyState extends StatelessWidget {
  const DesignPageEmptyState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * (1.5 / 3),
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/lonebackground.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 150,
              //  left: MediaQuery.of(context).size.width / 2 - 20,
              child: Image.asset(
                'assets/images/loneforeground.png',
                width: MediaQuery.of(context).size.width * (2 / 3),
                height: MediaQuery.of(context).size.width * (1 / 3),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        Text(
          'It is lonely in here\ncreate a user profile\nto spice things up!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF202020),
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key key, @required this.onEditPressed}) : super(key: key);

  final Function onEditPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      return Column(
        children: [
          SizedBox(height: 50),
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Color(0xFFF0E8FC),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(state.username, style: _blackText),
                    Text(state.email, style: _blackText.copyWith(fontSize: 14)),
                    Text(state.phonenumber,
                        style: _blackText.copyWith(fontSize: 14)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2 - 35,
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<RegistrationCubit>()
                                  .deleteUserProfile();
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(
                                  color: flutterUnleashedTheme.primaryColor,
                                  width: 1.5),
                              backgroundColor: Color(0xFFF0E8FC),
                              onSurface: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Delete Profile',
                              style: textStyle.copyWith(
                                  color: flutterUnleashedTheme.primaryColor),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2 - 35,
                          child: TextButton(
                            onPressed: onEditPressed,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor:
                                  flutterUnleashedTheme.primaryColor,
                              onSurface: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Edit Profile',
                              style: textStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: -40,
                right: MediaQuery.of(context).size.width / 2 - 30,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: flutterUnleashedTheme.primaryColor,
                    border: Border.all(
                        color: flutterUnleashedTheme.colorScheme.primaryVariant,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      state.username.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}

class QouteOfTheDay extends StatelessWidget {
  const QouteOfTheDay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Qoute of the Day',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            child: AnimatedTextKit(
              pause: Duration(milliseconds: 1800),
              repeatForever: true,
              animatedTexts: [
                TyperAnimatedText('It is not enough to do your best,'),
                TyperAnimatedText('you must know what to do,'),
                TyperAnimatedText('and then do your best'),
                TyperAnimatedText('- W.Edwards Deming'),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FavouritesHeading extends StatelessWidget {
  const FavouritesHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<PokemonCubit, PokemonState>(builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Favourites',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            state.favourites.length == 0
                ? Container()
                : Text(
                    'Double tap image to delete',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
          ],
        );
      }),
    );
  }
}

class FavouritePokemonsGridView extends StatelessWidget {
  const FavouritePokemonsGridView({Key key, @required this.onFavouritePressed})
      : super(key: key);

  final Function onFavouritePressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        if (state.favourites.length == 0) {
          return Column(
            children: [
              Text(
                'your favourites list is empty\nBrowse pokemons and add them here',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: onFavouritePressed,
                  style: TextButton.styleFrom(
                    textStyle: textStyle.copyWith(color: Color(0xFFFFFFF)),
                    primary: Colors.white,
                    backgroundColor: flutterUnleashedTheme.primaryColor,
                    onSurface: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text('Browse Pokemons'),
                ),
              ),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: MediaQuery.of(context).size.width /
                2 *
                (state.favourites.length / 2).ceil(),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                final pokemon = state.favourites[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                        child: GestureDetector(
                      onDoubleTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        context
                            .read<PokemonCubit>()
                            .deleteFavorites(pokemon.name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Material(
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/pokemons/${pokemon.name}.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
