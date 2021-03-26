import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:flutter_unleashed/cubit/pokemon_cubit.dart';
import 'package:flutter_unleashed/data/model/pokemon.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';

class PokemonCard extends StatefulWidget {
  PokemonCard({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;
  @override
  _PokemonCardState createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  bool _isExpanded = false;

  void _expand() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isExpanded ? _isExpanded = false : _isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * (1 / 3),
                width: MediaQuery.of(context).size.width * (1 / 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(
                      'assets/images/pokemons/${widget.pokemon.name}.jpg'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width * (2 / 3) - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${widget.pokemon.key.toString()} : ${widget.pokemon.value.toString()}',
                        style: blackText),
                    Text('${widget.pokemon.name}', style: blackText),
                    SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type', style: greyText),
                        for (var type in widget.pokemon.type)
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color:
                                      Color(int.tryParse('0xFF${type.color}')),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Text(type.type, style: whiteText),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: _expand,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: flutterUnleashedTheme.primaryColor,
                                width: 1.5)),
                        child: Text(
                          _isExpanded ? "Less" : "Read More...",
                          style: textStyle.copyWith(
                              color: flutterUnleashedTheme.primaryColor,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Container(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Species: ',
                            style: greyText.copyWith(fontSize: 13)),
                        Text("${widget.pokemon.species}",
                            style: blackText.copyWith(fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text("${widget.pokemon.description}",
                        style: blackText.copyWith(fontSize: 13)),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          context
                              .read<PokemonCubit>()
                              .addToFavorites('${widget.pokemon.name}');
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: flutterUnleashedTheme.primaryColor,
                          onSurface: Colors.grey,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        child: Text(
                          'Add To Favourites',
                          style: textStyle.copyWith(
                              color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(height: 5)
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
            ),
          ),
        ],
      ),
    );
  }
}

final blackText = TextStyle(
    color: Colors.black87,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14);

final greyText = TextStyle(
    color: Colors.grey,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 14);

final whiteText = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 12);
