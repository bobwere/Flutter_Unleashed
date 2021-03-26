import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_unleashed/cubit/pokemon_cubit.dart';
import 'package:flutter_unleashed/presentation/widgets/dictionary_page_widget.dart';
import 'package:flutter_unleashed/presentation/widgets/response_page_widgets.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  List<String> _sortByOptions = [
    'unsorted dictionary',
    'sort by numeric key',
    'sort by alpha key'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text(
            'Sort dictionary:',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FilterByDropDown(
              items: _sortByOptions,
              hintText: 'unsorted dictionary',
              width: MediaQuery.of(context).size.width * (2 / 3),
              onItemSelected: (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
                switch (value) {
                  case 'unsorted dictionary':
                    context.read<PokemonCubit>().unsortedDictionary();
                    break;
                  case 'sort by numeric key':
                    context.read<PokemonCubit>().sortByNumericKey();
                    break;
                  case 'sort by alpha key':
                    context.read<PokemonCubit>().sortByAlphaKey();
                    break;
                  default:
                }
              }),
        ),
        BlocBuilder<PokemonCubit, PokemonState>(
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = state.pokemons[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child:
                          FadeInAnimation(child: PokemonCard(pokemon: pokemon)),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
